resource "aws_amplify_app" "this" {
  name = var.app_name

  repository = var.repository_url
  branch     = var.branch
}

resource "aws_appsync_graphql_api" "this" {
  name          = "${var.app_name}-graphql-api"
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  user_pool_config {
    user_pool_id = aws_cognito_user_pool.this.id
  }
}

resource "aws_cognito_user_pool" "this" {
  name = "${var.app_name}-user-pool"
  // more configuration here...
}

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name = "${var.app_name}-identity-pool"
  // more configuration here...
}

// Add resources for DynamoDB, S3 bucket, EventBridge, IAM roles, etc., following the same pattern
