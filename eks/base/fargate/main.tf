module "fargate_profile" {
  source                       = "terraform-aws-modules/eks/aws//modules/fargate-profile"
  version                      = "20.8.5"
  create                       = true
  name                         = "${var.resource_prefix}-${var.environment}-${var.app_name}-${var.fargate_profile_name}"
  cluster_name                 = var.cluster_name
  create_iam_role              = true
  iam_role_name                = "${var.resource_prefix}-${var.environment}-${var.app_name}-${var.fargate_profile_namespace}-role"
  iam_role_attach_cni_policy   = true
  iam_role_additional_policies = var.additional_policies
  subnet_ids                   = var.subnet_ids
  timeouts = {
    create = "5m"
    update = "5m"
  }
  selectors = [{
    namespace = var.fargate_profile_namespace
  }]

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}