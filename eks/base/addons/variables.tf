variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster."
}
variable "cluster_endpoint" {
  type        = string
  description = "The endpoint for your EKS Kubernetes API server."
}
variable "cluster_version" {
  type        = string
  description = "The Kubernetes server version for the EKS cluster."
}

variable "oidc_provider_arn" {
  type        = string
  description = "The ARN of the OIDC Identity Provider."
}

variable "cluster_certificate_authority_data" {
  type        = string
  description = "The base64 encoded certificate data required to communicate with your cluster."
}

variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

# variable "eks_addons_service_account_role_arn" {}




