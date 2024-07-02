output "cluster_endpoint" {
  value = module.cluster.cluster_endpoint
}
output "cluster_certificate_authority_data" {
  value = module.cluster.cluster_certificate_authority_data
}

output "cluster_name" {
  value = module.cluster.cluster_name
}

output "cluster_id" {
  value = module.cluster.cluster_id
}

output "cluster_arn" {
  value = module.cluster.cluster_arn
}


output "cluster_primary_security_group_id" {
  value = module.cluster.cluster_primary_security_group_id
}


output "cluster_service_cidr" {
  value = module.cluster.cluster_service_cidr
}

output "cluster_version" {
  value = module.cluster.cluster_version
}

output "oidc_provider_arn" {
  value = module.cluster.oidc_provider_arn
}

output "oidc_provider" {
  description = "The OpenID Connect identity provider (issuer URL without leading `https://`)"
  value       = module.cluster.oidc_provider
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = module.cluster.cluster_oidc_issuer_url
}


output "cluster_iam_role_arn" {
  value = module.cluster.cluster_iam_role_arn
}