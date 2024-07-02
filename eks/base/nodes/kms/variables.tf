variable "cluster_iam_role_arn" {
  type        = string
  description = "IAM Role ARN of the EKS cluster."
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}