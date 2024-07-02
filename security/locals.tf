
locals {
  private = "private"
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