variable "irsa-role-name" {}
variable "oidc_provider_arn" {}
variable "autoscaller_cluster_name" {}

variable "app_name" {
  type        = string
  description = "Name of the application."
}

variable "environment" {
  description = "The environment name"
}

variable "resource_prefix" {
  description = "The prefix to be used on all resources"
}
