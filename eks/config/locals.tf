data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  aws_region = data.aws_region.current.name
}


locals {
  region = var.aws_region

}
