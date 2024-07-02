data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  aws_region = data.aws_region.current.name
  account_id = data.aws_caller_identity.current.account_id
}



locals {
  region = var.aws_region
  # name   = "ex-${basename(path.cwd)}"
  name        = "aws-observability-accelerator"
  description = "Amazon Managed Grafana workspace for ${local.name}"
  # region               = data.aws_region.current.name
  # eks_cluster_endpoint = data.aws_eks_cluster.this.endpoint
  eks_cluster_endpoint       = var.cluster_endpoint
  eks_cluster_ca_certificate = var.cluster_certificate_authority_data
  create_new_workspace       = var.managed_prometheus_workspace_id == "" ? true : false

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  tags = {
    GithubRepo = "terraform-aws-observability-accelerator"
    GithubOrg  = "aws-observability"
    Source     = "github.com/aws-observability/terraform-aws-observability-accelerator"
  }
}