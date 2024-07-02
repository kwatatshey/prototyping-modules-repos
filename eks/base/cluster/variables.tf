
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

# create some variables
variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "vpc_id" {}
variable "subnet_ids" {}


variable "developer_roles" {
  type        = list(string)
  description = "List of Kubernetes developer roles."
}


variable "developer_users" {
  type        = list(string)
  description = "List of Kubernetes developers."
}

variable "developer_user_group" {
  type        = string
  description = "Name of the kube group for developers."
}


# variable "oic_role_configurations" {
#   type = map(object({
#     role_name            = string
#     assume_role_actions  = list(string)
#     service_account      = string
#     namespace            = string
#   }))
# }


variable "oic_role_configurations" {
  type = map(object({
    role_name           = string
    assume_role_actions = list(string)
    namespace           = string
    service_account     = string
    policy_file         = string
  }))
}

variable "cluster_additional_security_group_ids" {
  type        = list(string)
  description = "List of additional security group IDs to attach to the EKS cluster."

}

variable "enable_creation_role_with_oidc" {
  type        = bool
  description = "Enable creation of IAM roles with OIDC."
}
