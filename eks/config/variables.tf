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

variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

# create some variables
variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}
variable "cluster_endpoint" {
  type        = string
  description = "Endpoint for your Kubernetes API server."
}

variable "cluster_arn" {
  type        = string
  description = "Amazon Resource Name (ARN) of the cluster."
}
variable "cluster_certificate_authority_data" {
  type        = string
  description = "Base64 encoded certificate data required to communicate with the cluster."
}
variable "spot_termination_handler_chart_name" {
  type        = string
  description = "EKS Spot termination handler Helm chart name."
}
variable "spot_termination_handler_chart_repo" {
  type        = string
  description = "EKS Spot termination handler Helm repository name."
}
variable "spot_termination_handler_chart_version" {
  type        = string
  description = "EKS Spot termination handler Helm chart version."
}
variable "spot_termination_handler_chart_namespace" {
  type        = string
  description = "Kubernetes namespace to deploy EKS Spot termination handler Helm chart."
}


variable "admin_roles" {
  type        = list(string)
  description = "List of Kubernetes admin roles."
}
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

# create some variables
variable "dns_base_domain" {
  type        = string
  description = "DNS Zone name to be used from EKS Ingress."
}
variable "ingress_gateway_name" {
  type        = string
  description = "Load-balancer service name."
}
variable "ingress_gateway_iam_role" {
  type        = string
  description = "IAM Role Name associated with load-balancer service."
}


variable "ingress_gateway_chart_name" {
  type        = string
  description = "Ingress Gateway Helm chart name."
}
variable "ingress_gateway_chart_repo" {
  type        = string
  description = "Ingress Gateway Helm repository name."
}
variable "ingress_gateway_chart_version" {
  type        = string
  description = "Ingress Gateway Helm chart version."
}





variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}


variable "public_subnets" {
  description = "The IDs of the public subnets"
  type        = list(string)
}
variable "private_subnets" {
  description = "The IDs of the private subnets"
  type        = list(string)
}

variable "security_groups" {
  description = "The IDs of the security groups"
  type        = list(string)
}

variable "ALB_SECURITY_GROUP_ID" {
  type        = string
  description = "The ID of the ALB security group"
}

variable "EKS_CLUSTER_SECURITY_GROUP_ID" {
  type        = string
  description = "The ID of the EKS cluster security group"
}

variable "argocd_ingress_name" {
  description = "ArgoCD ingress"
  type        = string
}

variable "argocd_ingress_alb_name" {
  description = "The name of the ALB"
  type        = string
}


variable "oidc_provider_arn" {
  description = "The ARN of the OIDC provider for the EKS cluster"
  type        = string

}
variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
}

# variable "grafana_api_key" {
#   description = "API key for authorizing the Grafana provider to make changes to Amazon Managed Grafana"
#   type        = string
#   sensitive   = true
# }

