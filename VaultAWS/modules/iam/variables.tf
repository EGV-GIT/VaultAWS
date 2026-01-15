variable "project_name" {
  type        = string
  description = "Project name used for naming"
}

variable "admin_principal_arn" {
  type        = string
  description = "ARN allowed to assume IAM roles"
}

variable "region" {
  type        = string
  description = "AWS region"
}



