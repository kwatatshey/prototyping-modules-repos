output "eks_addons_service_account_role_arn" {
  value = module.eks_common_iam.iam_role_arn
}

output "additional_policy_arn" {
  value = module.additional_policy.arn
}