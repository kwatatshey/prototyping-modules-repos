#tfsec:ignore:aws-eks-no-public-cluster-access
#tfsec:ignore:aws-eks-no-public-cluster-access-to-cidr
#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-ec2-no-public-ingress-sgr
module "cluster" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "20.8.5"
  cluster_name                             = "${var.resource_prefix}-${var.environment}-${var.app_name}-${var.cluster_name}"
  cluster_version                          = "1.29"
  cluster_endpoint_private_access          = true
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true
  enable_irsa                              = true
  cluster_enabled_log_types                = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  subnet_ids                               = var.subnet_ids
  vpc_id                                   = var.vpc_id
  # cluster_additional_security_group_ids    = [aws_security_group.node_security_group_additional_rules.id, aws_security_group.alb.id]
  # cluster_additional_security_group_ids = [aws_security_group.cluster_additional_security_group_ids.id]
  cluster_additional_security_group_ids = var.cluster_additional_security_group_ids
  # cluster_additional_security_group_ids = concat(
  #   var.create_node_security_group ? [aws_security_group.main[1].id] : [], # node_security_group
  # [aws_security_group.main[0].id])
  access_entries = merge(local.user_access_entries, local.role_access_entries)
  # control_plane_subnet_ids                 = var.control_plane_subnet_ids
  tags = local.all_tags
  # tags = merge(local.tags, {
  #   # NOTE - if creating multiple security groups with this module, only tag the
  #   # security group that Karpenter should utilize with the following tag
  #   # (i.e. - at most, only one security group should have this tag in your account)
  #   "karpenter.sh/discovery" = local.name
  # })
}

locals {
  private = "private"
  public  = "public"
}

locals {
  common_tags = {
    "karpenter.sh/discovery" = local.private
    "Environment"            = var.environment
  }

  additional_tags = {
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }

  all_tags = merge(local.common_tags, local.additional_tags)
}