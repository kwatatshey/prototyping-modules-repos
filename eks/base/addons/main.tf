module "eks_blueprints_addons" {
  source                  = "aws-ia/eks-blueprints-addons/aws"
  version                 = "~> 1.0" #ensure to update this to the latest/desired version
  cluster_name            = var.cluster_name
  cluster_endpoint        = var.cluster_endpoint
  cluster_version         = var.cluster_version
  oidc_provider_arn       = var.oidc_provider_arn
  enable_external_secrets = true
  enable_gatekeeper       = true
  # enable_ingress_nginx                         = true
  # enable_secrets_store_csi_driver              = true
  # enable_secrets_store_csi_driver_provider_aws = true
  enable_argo_rollouts  = true
  enable_argo_workflows = true
  enable_argo_events    = true

  eks_addons_timeouts = {
    create = "5m"
    update = "5m"
    delete = "5m"
  }
  eks_addons = {
    # aws-ebs-csi-driver = {
    #   most_recent       = true
    #   resolve_conflicts = "OVERWRITE"
    #   # service_account_role_arn = var.eks_addons_service_account_role_arn
    # } This will neeed atleast 2 worker nodees, if one node is there then it will not work (InsufficientNumberOfReplicas)
    # vpc-cni = {
    #   most_recent              = true
    #   resolve_conflicts        = "OVERWRITE"
    #   service_account_role_arn = var.eks_addons_service_account_role_arn
    # }
    vpc-cni = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
      # service_account_role_arn = var.eks_addons_service_account_role_arn
      before_compute = true
      configuration_values = jsonencode({
        env = {
          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
    # aws-efs-csi-driver = {
    #   most_recent       = true
    #   resolve_conflicts = "OVERWRITE"
    #   # service_account_role_arn = var.eks_addons_service_account_role_arn
    # } This will neeed atleast 2 worker nodees, if one node is there then it will not work (InsufficientNumberOfReplicas)
    eks-pod-identity-agent = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
      # service_account_role_arn = var.eks_addons_service_account_role_arn
    }
    # dynatrace_dynatrace-operator = {
    #   most_recent       = true
    #   resolve_conflicts = "OVERWRITE"
    #   # service_account_role_arn = var.eks_addons_service_account_role_arn
    # }


    amazon-cloudwatch-observability = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
      # service_account_role_arn = var.eks_addons_service_account_role_arn
    }
    kube-proxy = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
      # service_account_role_arn = var.eks_addons_service_account_role_arn
    }

    # snapshot-controller = {
    #   most_recent       = true
    #   resolve_conflicts = "OVERWRITE"
    #   # service_account_role_arn = var.eks_addons_service_account_role_arn
    # }
    # grafana = {
    #   most_recent              = false
    #   resolve_conflicts        = "OVERWRITE"
    #   service_account_role_arn = var.eks_addons_service_account_role_arn
    # }

  }
  # cert_manager_route53_hosted_zone_arns  = var.cert_manager_route53_hosted_zone_arns

  tags = {
    Environment = "dev"
  }
  # depends_on = [module.eks_managed_node_groups]
}