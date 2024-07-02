variable "main_network_block" {
  type        = string
  description = "Base CIDR block to be used in our VPC."
}
variable "cluster_azs" {
  type        = list(string)
  description = "List of Availability Zones to be used in EKS"
}


variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "subnet_prefix_extension" {
  type        = number
  description = "CIDR block bits extension to calculate CIDR blocks of each subnetwork."
}
variable "zone_offset" {
  type        = number
  description = "CIDR block bits extension offset to calculate Public subnets, avoiding collisions with Private subnets."
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