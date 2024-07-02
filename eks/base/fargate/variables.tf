variable "additional_policies" {
  type        = map(string)
  description = "Additional policies to be added to the IAM role."
}

variable "fargate_profile_namespace" {
  type        = string
  description = "Namespace to be used by the Fargate Profile."
}
variable "fargate_profile_name" {
  type        = string
  description = "Name of the Fargate Profile."
}

variable "resource_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}

variable "environment" {
  type        = string
  description = "Environment name."
}


variable "app_name" {
  type        = string
  description = "Name of the application."
}


variable "cluster_name" {
  type        = string
  description = "EKS cluster name."

}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to launch Fargate Profiles in."
}