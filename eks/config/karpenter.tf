provider "aws" {
  region = var.aws_region
  alias  = "virginia"
}


data "aws_availability_zones" "available" {}
data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.virginia
}

module "karpenter" {
  source                        = "terraform-aws-modules/eks/aws//modules/karpenter"
  version                       = "20.11.1"
  cluster_name                  = var.cluster_name
  create                        = true
  create_iam_role               = true
  create_node_iam_role          = true
  node_iam_role_use_name_prefix = false
  node_iam_role_additional_policies = {
    "worker_node_policy"                  = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "cni_policy"                          = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "cloudwatch_agent_policy"             = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "ssm_managed_instance_core_policy"    = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "vpc_resource_controller_policy"      = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
    "AmazonEC2ContainerServiceforEC2Role" = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "CloudWatchFullAccess"                = "arn:aws:iam::aws:policy/CloudWatchFullAccess",
    "CloudWatchLogsFullAccess"            = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "CloudWatchEventsFullAccess"          = "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess"
    "AmazonEC2FullAccess"                 = "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "AmazonEBSCSIDriverPolicy"            = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }
  create_access_entry     = true
  create_instance_profile = true
  enable_irsa             = true
  iam_role_name           = "${var.cluster_name}-KarpenterController"
  iam_role_description    = "IAM role for Karpenter Controller"
  # iam_role_name = "${replace(replace(var.cluster_name, "/", "-"), ":", "-")}-KarpenterController"
  iam_role_use_name_prefix   = false
  iam_policy_use_name_prefix = false
  iam_role_policies = {
    "worker_node_policy"                  = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "cni_policy"                          = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "cloudwatch_agent_policy"             = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "ssm_managed_instance_core_policy"    = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "vpc_resource_controller_policy"      = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
    "AmazonEC2ContainerServiceforEC2Role" = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "CloudWatchFullAccess"                = "arn:aws:iam::aws:policy/CloudWatchFullAccess",
    "CloudWatchLogsFullAccess"            = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "CloudWatchEventsFullAccess"          = "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess"
    "AmazonEC2FullAccess"                 = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    "IAMFullAccess"                       = "arn:aws:iam::aws:policy/IAMFullAccess",
    "AmazonEBSCSIDriverPolicy"            = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }
  irsa_namespace_service_accounts = ["kube-system:karpenter"]
  irsa_oidc_provider_arn          = var.oidc_provider_arn
  service_account                 = "karpenter"
  create_pod_identity_association = true
  enable_pod_identity             = true
  queue_name                      = "${var.resource_prefix}-${var.environment}-${var.app_name}-karpenter"
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}



################################################################################
# Karpenter Helm chart & manifests
# Not required; just to demonstrate functionality of the sub-module
################################################################################

resource "helm_release" "karpenter_crd" {
  namespace        = "kube-system"
  create_namespace = true

  name         = "karpenter-crd"
  repository   = "oci://public.ecr.aws/karpenter"
  chart        = "karpenter-crd"
  version      = "0.36.2"
  replace      = true
  force_update = true
}


resource "helm_release" "karpenter" {
  depends_on          = [kubernetes_config_map_v1_data.aws_auth_users, helm_release.karpenter_crd]
  namespace           = "kube-system"
  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  chart               = "karpenter"
  version             = "0.36.2"
  replace             = true
  wait                = false
  # set {
  #   name  = "serviceMonitor.enabled"
  #   value = "True"
  # }
  set {
    name  = "settings.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "settings.clusterEndpoint"
    value = var.cluster_endpoint
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.karpenter.iam_role_arn
  }

  set {
    name  = "settings.defaultInstanceProfile"
    value = module.karpenter.instance_profile_name
  }

  set {
    name  = "settings.interruptionQueueName"
    value = module.karpenter.queue_name
  }
  set {
    name  = "settings.featureGates.drift"
    value = "True"
  }

  set {
    name  = "tolerations[0].key"
    value = "system"
  }

  set {
    name  = "tolerations[0].value"
    value = "owned"
  }

  set {
    name  = "tolerations[0].operator"
    value = "Equal"
  }

  set {
    name  = "tolerations[0].effect"
    value = "NoSchedule"
  }

  set {
    name  = "replicas"
    value = 3
  }

  # set {
  #   name  = "logLevel"
  #   value = "debug"
  # }
  # values = [
  #   <<-EOT
  #   settings:
  #     clusterName: ${var.cluster_name}
  #     clusterEndpoint: ${var.cluster_endpoint}
  #     interruptionQueue: ${module.karpenter.queue_name}
  #   EOT
  # ]
}


# Retrieve ARM AMI ID from AWS SSM Parameter Store
data "aws_ssm_parameter" "arm_ami_id" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2-arm64/recommended/image_id"
}

# Retrieve AMD AMI ID from AWS SSM Parameter Store
data "aws_ssm_parameter" "amd_ami_id" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2/recommended/image_id"
}

# Retrieve GPU AMI ID from AWS SSM Parameter Store (if needed)
data "aws_ssm_parameter" "gpu_ami_id" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2-gpu/recommended/image_id"
}

locals {
  private = "private"
  public  = "public"
}

###/////////////////////////////////////////////////////////////////////////////////////

resource "kubectl_manifest" "karpenter_spot_pool" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: spot
    spec:
      disruption:
        consolidationPolicy: WhenUnderutilized
        expireAfter: 72h # 30 * 24h = 720h
      limits:
        cpu: 1000
        memory: 4000Gi
      template:
        spec:
          nodeClassRef:
            name: default
          requirements:
            - key: karpenter.sh/capacity-type
              operator: In
              values: ["spot"]
            - key: kubernetes.io/arch
              operator: In
              values: ["amd64"]
            - key: kubernetes.io/os
              operator: In
              values: ["linux"]
            - key: karpenter.k8s.aws/instance-size
              operator: NotIn
              values: [nano, micro]
            - key: "karpenter.k8s.aws/instance-category"
              operator: In
              values: ["c", "t", "m", "r"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["1", "2", "4", "6", "8", "10", "12", "14", "16", "32", "48", "64"]
          # taints:
          # - key: spot
          #   value: "true"
          #   effect: NoSchedule
          kubelet:         
            evictionHard:
              memory.available: 500Mi
              nodefs.available: 10%
              nodefs.inodesFree: 10%
              imagefs.available: 5%
              imagefs.inodesFree: 5%
              pid.available: 7%
            evictionSoft:
              memory.available: 1Gi
              nodefs.available: 15%
              nodefs.inodesFree: 15%
              imagefs.available: 10%
              imagefs.inodesFree: 10%
              pid.available: 10%
            evictionSoftGracePeriod:
              memory.available: 1m
              nodefs.available: 1m30s
              nodefs.inodesFree: 2m
              imagefs.available: 1m30s
              imagefs.inodesFree: 2m
              pid.available: 2m
            evictionMaxPodGracePeriod: 60
            maxPods: 110
YAML
  depends_on = [
    helm_release.karpenter
  ]
}


resource "kubectl_manifest" "karpenter_on_demand_pool" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: on-demand
    spec:
      disruption:
        consolidationPolicy: WhenEmpty
        consolidateAfter: 300s
        expireAfter: 72h
      limits:
        cpu: 1000
        memory: 4000Gi
      template:
        spec:
          nodeClassRef:
            name: default
          requirements:
            - key: karpenter.sh/capacity-type
              operator: In
              values: ["on-demand"]
            - key: kubernetes.io/arch
              operator: In
              values: ["arm64"]
            - key: karpenter.k8s.aws/instance-size
              operator: NotIn
              values: [nano, micro, small]
            - key: karpenter.k8s.aws/instance-family
              operator: In
              values: ["c7g"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["1", "2", "4", "6", "8", "10", "12", "14", "16", "32", "48", "64"]
          # taints:
          # - key: on-demand
          #   value: "true"
          #   effect: NoSchedule
          kubelet:         
            evictionHard:
              memory.available: 500Mi
              nodefs.available: 10%
              nodefs.inodesFree: 10%
              imagefs.available: 5%
              imagefs.inodesFree: 5%
              pid.available: 7%
            evictionSoft:
              memory.available: 1Gi
              nodefs.available: 15%
              nodefs.inodesFree: 15%
              imagefs.available: 10%
              imagefs.inodesFree: 10%
              pid.available: 10%
            evictionSoftGracePeriod:
              memory.available: 1m
              nodefs.available: 1m30s
              nodefs.inodesFree: 2m
              imagefs.available: 1m30s
              imagefs.inodesFree: 2m
              pid.available: 2m
            evictionMaxPodGracePeriod: 60
            maxPods: 110
YAML
  depends_on = [
    helm_release.karpenter
  ]
}



resource "kubectl_manifest" "karpenter_on_demand_monitoring_pool" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: monitoring
    spec:
      disruption:
        consolidationPolicy: WhenUnderutilized
        expireAfter: 1440h
      limits:
        cpu: 1000
        memory: 4000Gi
      template:
        spec:
          nodeClassRef:
            name: default
          requirements:
            - key: karpenter.sh/capacity-type
              operator: In
              values: ["on-demand"]
            - key: kubernetes.io/arch
              operator: In
              values: ["arm64"]
            - key: karpenter.k8s.aws/instance-family
              operator: In
              values: ["c7g"]
          # taints:
          # - key: monitoring
          #   value: "true"
          #   effect: NoSchedule
          kubelet:         
            evictionHard:
              memory.available: 500Mi
              nodefs.available: 10%
              nodefs.inodesFree: 10%
              imagefs.available: 5%
              imagefs.inodesFree: 5%
              pid.available: 7%
            evictionSoft:
              memory.available: 1Gi
              nodefs.available: 15%
              nodefs.inodesFree: 15%
              imagefs.available: 10%
              imagefs.inodesFree: 10%
              pid.available: 10%
            evictionSoftGracePeriod:
              memory.available: 1m
              nodefs.available: 1m30s
              nodefs.inodesFree: 2m
              imagefs.available: 1m30s
              imagefs.inodesFree: 2m
              pid.available: 2m
            evictionMaxPodGracePeriod: 60
            maxPods: 110
YAML
  depends_on = [
    helm_release.karpenter
  ]
}


resource "kubectl_manifest" "karpenter_node_class" {
  yaml_body = <<-YAML
    apiVersion: karpenter.k8s.aws/v1beta1
    kind: EC2NodeClass
    metadata:
      name: default
    spec:
      amiFamily: AL2
      role: ${module.karpenter.node_iam_role_name}

      detailedMonitoring: true

      metadataOptions:
        httpEndpoint: enabled
        httpProtocolIPv6: disabled
        httpPutResponseHopLimit: 2
        httpTokens: required
      # Optional, overrides autogenerated userdata with a merge semantic

      blockDeviceMappings:
        - deviceName: /dev/xvda
          ebs:
            volumeSize: 40Gi
            volumeType: gp3
            encrypted: true
            deleteOnTermination: true

      subnetSelectorTerms:
        - tags:
            "karpenter.sh/discovery": "${local.private}"
            "Environment": "${var.environment}"
        - id: "${join(",", var.private_subnets)}"

      securityGroupSelectorTerms:
        - tags:
            "karpenter.sh/discovery": "${local.private}"
            "Environment": "${var.environment}"
        - id: "${join(",", var.security_groups)}"

      userData: |
        echo "Hello world"   
      associatePublicIPAddress: true

      amiSelectorTerms:
        - id: "${data.aws_ssm_parameter.arm_ami_id.value}"
        - id: "${data.aws_ssm_parameter.amd_ami_id.value}"
        # Uncomment the following lines if you want to include GPU AMI
        # - id: "${data.aws_ssm_parameter.gpu_ami_id.value}"
        # - name: "amazon-eks-node-${var.cluster_version}-*"
      # instanceTypes:
      #   - t3.small
      #   - t3.medium
      #   - t3.large
      #   - t3a.small
      #   - t3a.medium
      #   - t3a.large
      #   - c7g.medium
      #   - c7g.large
      # Optional, propagates tags to underlying EC2 resources
      tags:
        Name: from-karpenter
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}

###/////////////////////////////////////////////////////////////////////////////////////

resource "kubectl_manifest" "karpenter_inflate_deployment" {
  yaml_body = <<-YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: inflate
    spec:
      replicas: 0
      selector:
        matchLabels:
          app: inflate
      template:
        metadata:
          labels:
            app: inflate
        spec:
          terminationGracePeriodSeconds: 0
          tolerations:
            - key: "node.kubernetes.io/not-ready"
              operator: "Exists"
              effect: "NoExecute"
            - key: "eks.amazonaws.com/compute-type"
              operator: "Exists"
              effect: "NoSchedule"
          containers:
            - name: inflate
              image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
              resources:
                requests:
                  cpu: 1
                  memory: 1.5Gi
                limits:
                  cpu: 2
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}
