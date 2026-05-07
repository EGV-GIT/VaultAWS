variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
  default     = "VaultAWS"
}

variable "region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "ap-southeast-2"
}

variable "alert_email" {
  type        = string
  description = "Email address to receive security alerts"
}

variable "admin_principal_arn" {
  type        = string
  description = "ARN of the IAM user or role allowed to assume deploy and break-glass roles"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones to use"
  default     = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}
