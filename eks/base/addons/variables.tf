variable "cluster_name" {}
variable "cluster_endpoint" {}
variable "cluster_version" {}
variable "oidc_provider_arn" {}
variable "cluster_certificate_authority_data" {}

variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

# variable "eks_addons_service_account_role_arn" {}




