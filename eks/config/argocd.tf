# Fetch SSH private key from AWS SSM Parameter Store
data "aws_ssm_parameter" "github_ssh_private_key" {
  name = "/github/ssh_private_key"
}

# data "aws_secretmanager_secret_version" "ssh_private_key" {
#   secret_id = "arn:aws:secretsmanager:us-east-1:955769636964:secret:sshPrivateKey



# Install ArgoCD Helm chart
resource "helm_release" "argocd" {
  depends_on       = [kubernetes_config_map_v1_data.aws_auth_users]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.1.0"
  namespace        = "argocd"
  create_namespace = true

  wait          = true
  wait_for_jobs = true
  timeout       = 600

  set {
    name  = "image.pullPolicy"
    value = "Always"
  }
}

# Install sealed-secrets for secret encryption
resource "helm_release" "sealed_secrets" {
  name             = "sealed-secrets"
  repository       = "https://bitnami-labs.github.io/sealed-secrets"
  chart            = "sealed-secrets"
  version          = "2.13.2"
  namespace        = "kube-system"
  create_namespace = false

  set {
    name  = "image.pullPolicy"
    value = "Always"
  }

  set {
    name  = "replicas"
    value = 2
  }

  wait          = true
  wait_for_jobs = true
  depends_on    = [kubernetes_config_map_v1_data.aws_auth_users, helm_release.argocd]
}
# resource "kubectl_manifest" "gh_private_repo_key" {
#   yaml_body  = file("${path.module}/sealed-secrets/sealed-ssh-secret.yaml")
#   depends_on = [helm_release.sealed_secrets]
# }


# data "aws_secretsmanager_secret" "ssh_private_key" {
#   name = "sshPrivateKey"
# }

# data "aws_secretsmanager_secret_version" "ssh_private_key" {
#   secret_id = data.aws_secretsmanager_secret.ssh_private_key.id
# }

# resource "kubectl_manifest" "argoproj_ssh_creds" {
#   yaml_body  = <<-YAML
# apiVersion: v1
# kind: Secret
# metadata:
#   name: argoproj-ssh-creds
#   namespace: argocd
#   labels:
#     argocd.argoproj.io/secret-type: repo-creds
# stringData:
#   url: git@github.com:kwatatshey
#   type: git
#   sshPrivateKey: |
#     ${replace(replace(data.aws_secretsmanager_secret_version.ssh_private_key.secret_string, "\n", "\n    "), "\r", "")}
# YAML
#   depends_on = [helm_release.sealed_secrets]
# }




####SSH private key for accessing the private repo



resource "null_resource" "update_argocd_ingress" {
  # This triggers only when the ingress is being updated
  lifecycle {
    create_before_destroy = false
    replace_triggered_by  = [kubectl_manifest.ingress.id, kubernetes_ingress_class.argocd.id, kubectl_manifest.argogrpc.id]
  }

  provisioner "local-exec" {
    command = <<-EOT
      aws eks update-kubeconfig --region ${local.aws_region} --name ${var.cluster_name} && \
      kubectl config use-context ${var.cluster_arn} && \
      echo "Removing finalizers from ArgoCD Ingress..." && \
      kubectl patch ingress ${var.argocd_ingress_name} -n argocd -p '{"metadata":{"finalizers":null}}' --type=merge
    EOT

    interpreter = ["/bin/bash", "-c"]
  }
}

resource "kubectl_manifest" "argo_sgp" {
  yaml_body = <<-EOT
    apiVersion: vpcresources.k8s.aws/v1beta1
    kind: SecurityGroupPolicy
    metadata:
      name: argo-sgp
      namespace: argocd
    spec:
      podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-server
      securityGroups:
        groupIds:
          - ${var.ALB_SECURITY_GROUP_ID}
          - ${var.EKS_CLUSTER_SECURITY_GROUP_ID}
  EOT
  # depends_on = [helm_release.argocd]
  depends_on = [helm_release.argocd]
}


resource "null_resource" "delete_argocd_pods" {
  provisioner "local-exec" {
    command     = "aws eks update-kubeconfig --region ${local.aws_region} --name ${var.cluster_name} && kubectl config use-context ${var.cluster_arn} && kubectl delete pods --all -n=argocd"
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [kubectl_manifest.argo_sgp]
}

# Now we add the repository where the argo config lies -
# only needed because it is private. In this way, we have a repo
# dedicated to argo config and everybody can file PRs to it.
# NOTE: ArgoCD Repository is defined as a Kubernetes secret - don't be confused by that
resource "kubernetes_secret_v1" "argo_config_repo" {
  metadata {
    name      = "argocd-config-repo"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }
  type = "Opaque"
  data = {
    name          = "argocd-config"
    type          = "git"
    url           = "git@github.com:kwatatshey/argocd.git"
    project       = "*"
    sshPrivateKey = data.aws_ssm_parameter.github_ssh_private_key.value
  }
  # depends_on = [kubernetes_config_map_v1_data.aws_auth_users] to not include, only this below
  # depends_on = [kubectl_manifest.gh_private_repo_key]
  depends_on = [helm_release.argocd]
}


# Helm chart to deploy argo root application
resource "helm_release" "argocd-app" {
  name       = "argocd-app"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  namespace  = "argocd"
  version    = "1.4.1"
  timeout    = 600

  set {
    name  = "image.pullPolicy"
    value = "Always"
  }

  values = [
    file("${path.module}/values/argocd-app.yaml"),
  ]

  # depends_on = [helm_release.argocd]
  depends_on = [kubernetes_secret_v1.argo_config_repo]
}


