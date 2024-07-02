

output "node_group_autoscaling_group_names" {
  value = module.eks_managed_node_groups.node_group_autoscaling_group_names
}

output "additional_policy_arn" {
  value = module.additional_policy.arn
}

output "node_iam_role_arn" {
  value = module.eks_managed_node_groups.iam_role_arn
}

output "node_iam_role_name" {
  value = module.eks_managed_node_groups.iam_role_name
}

# output "nodegroup_role_1" {
#   description = "The IAM role name for the first node group"
#   value       = module.eks_managed_node_groups.iam_role_name[0]
# }

# output "nodegroup_role_2" {
#   description = "The IAM role name for the second node group"
#   value       = module.eks_managed_node_groups.iam_role_name[1]
# }