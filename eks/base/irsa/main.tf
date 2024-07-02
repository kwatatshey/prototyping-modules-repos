# Create a common IAM role for addons
module "eks_common_iam" {
  source                                             = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version                                            = "5.39.0"
  role_name                                          = "${var.resource_prefix}-${var.environment}-${var.app_name}-${var.irsa-role-name}"
  force_detach_policies                              = true
  attach_load_balancer_controller_policy             = true
  external_secrets_secrets_manager_create_permission = true
  attach_external_dns_policy                         = true
  attach_vpc_cni_policy                              = true
  vpc_cni_enable_ipv4                                = true
  vpc_cni_enable_ipv6                                = true
  attach_efs_csi_policy                              = true
  attach_ebs_csi_policy                              = true
  attach_amazon_managed_service_prometheus_policy    = true
  attach_cloudwatch_observability_policy             = true
  attach_cluster_autoscaler_policy                   = true
  role_policy_arns = {
    additional_policy = module.additional_policy.arn
  }
  # cluster_autoscaler_cluster_names                = [module.cluster.cluster_name]
  cluster_autoscaler_cluster_names   = [var.autoscaller_cluster_name]
  attach_karpenter_controller_policy = true




  oidc_providers = {
    ex = {
      provider_arn = var.oidc_provider_arn
      namespace_service_accounts = [
        "kube-system:aws-load-balancer-controller",
        "kube-system:external-dns",
      ]
    }
  }
}



# create IAM role for AWS Load Balancer Controller, and attach to EKS OIDC
module "eks_ingress_iam" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.33.0"

  role_name                              = "${var.resource_prefix}-${var.environment}-${var.app_name}-load-balancer-controller"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}

# create IAM role for External DNS, and attach to EKS OIDC
module "eks_external_dns_iam" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.33.0"

  role_name                     = "${var.resource_prefix}-${var.environment}-${var.app_name}-external-dns"
  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/*"]

  oidc_providers = {
    ex = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:external-dns"]
    }
  }
}


module "additional_policy" {
  source        = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version       = "5.39.0"
  create_policy = false
  name          = "${var.resource_prefix}-${var.environment}-${var.app_name}-custom-policy"
  path          = "/"
  description   = "Additional policy for eks node group"
  policy        = data.aws_iam_policy_document.additional_policy.json

  tags = {
    PolicyDescription = "Policy created using example from data source"
  }
}