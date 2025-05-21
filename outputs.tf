output "app_id" {
  value       = module.sample-qs.app_id
  description = "Amplify App ID"
}

output "graphql_api_id" {
  value       = module.sample-qs.graphql_api_id
  description = "AppSync GraphQL API ID"
}

output "user_pool_id" {
  value       = module.sample-qs.user_pool_id
  description = "Cognito User Pool ID"
}

output "identity_pool_id" {
  value       = module.sample-qs.identity_pool_id
  description = "Cognito Identity Pool ID"
}
