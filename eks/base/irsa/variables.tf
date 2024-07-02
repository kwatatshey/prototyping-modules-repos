variable "irsa-role-name" {
  type        = string
  description = "The name of the IAM role to be created."
}
variable "oidc_provider_arn" {
  type        = string
  description = "The ARN of the OIDC Identity Provider."
}

variable "autoscaller_cluster_name" {
  type        = string
  description = "The name of the EKS cluster."
}

variable "app_name" {
  type        = string
  description = "Name of the application."
}

variable "environment" {
  type        = string
  description = "The environment name"
}

variable "resource_prefix" {
  type        = string
  description = "The prefix to be used on all resources"
}
