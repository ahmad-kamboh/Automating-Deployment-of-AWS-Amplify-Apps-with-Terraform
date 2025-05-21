variable "cognito_users" {
  type = map(object({
    username         = string
    given_name       = string
    family_name      = string
    email            = string
    email_verified   = bool
    group_membership = list(string)
  }))
  description = "Cognito users to create"
}

variable "cognito_groups" {
  type = map(object({
    name        = string
    description = string
  }))
  description = "Cognito user pool groups for RBAC"
}
