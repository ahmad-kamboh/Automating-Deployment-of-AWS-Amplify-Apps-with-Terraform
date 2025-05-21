variable "app_name" {
  type        = string
  description = "Name of the Amplify application"
}

variable "repository_url" {
  type        = string
  description = "Git repository URL (optional)"
  default     = ""
}

variable "branch" {
  type        = string
  description = "Git branch to deploy from"
  default     = "main"
}

variable "cognito_users" {
  type = map(object({
    username         = string
    given_name       = string
    family_name      = string
    email            = string
    email_verified   = bool
    group_membership = list(string)
  }))
}

variable "cognito_groups" {
  type = map(object({
    name        = string
    description = string
  }))
}
