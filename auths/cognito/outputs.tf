output "user_pool_id" {
  value       = try(aws_cognito_user_pool.user_pool[*].id, null)
  description = "(Required) User pool the client belongs to."
}

output "user_pool_endpoint" {
  value       = try(aws_cognito_user_pool.user_pool[*].endpoint, null)
  description = "(Required) Endpoint of the user pool."
}

output "identity_pool_id" {
  value       = try(aws_cognito_identity_pool.identity_pool[*].id, null)
  description = "(Optional) The Cognito Identity Pool to use when configuring OAuth2.0."
}

output "name" {
  value       = try(aws_cognito_user_pool.user_pool[0].name, null)
  description = "(Required) Name of the application client."
}

output "app_client_id" {
  value       = try(aws_cognito_user_pool_client.client[0].id, null)
  description = "ID of the user pool client."
}

output "tags" {
  value       = module.labels.tags
  description = "A mapping of tags to assign to the resource."
}