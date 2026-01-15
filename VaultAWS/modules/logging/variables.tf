variable "project_name" {
  type        = string
  description = "Project name used for naming"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "alert_email" {
  type        = string
  description = "Email address to receive security alerts"
  default     = ""
}




