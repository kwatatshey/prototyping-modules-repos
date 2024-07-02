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

variable "name" {
  description = "The name of the security group"
}

variable "description" {
  description = "The description of the security group"
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

# Define ingress rules with CIDR blocks
variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules with CIDR blocks"
  default     = []
}

# Define ingress rules with IPv6 CIDR blocks
variable "ingress_with_ipv6_cidr_blocks" {
  description = "List of ingress rules with IPv6 CIDR blocks"
  default     = []
}

# Define ingress rules with source security group ID
variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules with source security group ID"
  default     = []
}

# Define ingress rules with self
variable "ingress_with_self" {
  description = "List of ingress rules with self"
  default     = []
}

# Define egress rules with CIDR blocks
variable "egress_with_cidr_blocks" {
  description = "List of egress rules with CIDR blocks"
  default     = []
}

# Define egress rules with IPv6 CIDR blocks
variable "egress_with_ipv6_cidr_blocks" {
  description = "List of egress rules with IPv6 CIDR blocks"
  default     = []
}

# Define timeouts for resource creation and deletion
variable "create_timeout" {
  description = "Timeout for resource creation"
  default     = "15m"
}

variable "delete_timeout" {
  description = "Timeout for resource deletion"
  default     = "45m"
}

variable "enable_source_security_group_id" {
  description = "Enable source security group ID for ALB security group ingress"
  default     = false
}

