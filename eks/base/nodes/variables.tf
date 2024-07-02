
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

# variable "security_group_node_name" {
#   type        = string
#   description = "Security Group Node"
# }

# variable "security_group_alb_name" {
#   type        = string
#   description = "Security Group ALB"
# }




variable "name" {}
variable "ami_type" {}
variable "min_size" {}
variable "max_size" {}
variable "desired_size" {}
variable "instance_types" {}
variable "capacity_type" {}
# variable "use_custom_launch_template" {}
# variable "disk_size" {}
variable "network_interfaces" {}
variable "eks_managed_node_groups" {}
variable "ebs_kms_key_arn" {}
variable "tag_specifications" {}
# variable "tags" {}

# variable "cluster_iam_role_arn" {}




variable "vpc_id" {}
variable "subnet_ids" {}
variable "cluster_version" {}



variable "autoscaling_average_cpu" {
  type        = number
  description = "Average CPU threshold to autoscale EKS EC2 instances."
}

variable "cluster_service_cidr" {
  type        = string
  description = "CIDR block for the EKS cluster service."
}



variable "iam_role_nodes_additional_policies" {
  type        = map(string)
  description = "List of additional IAM policies to attach to EKS managed node groups."
}

variable "cluster_primary_security_group_id" {
  type        = string
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to attach to the EKS cluster."
}