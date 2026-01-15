terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

module "vpc" {
  source       = "../../modules/vpc"
  project_name = "VaultAWS"
  region       = "ap-southeast-2"

  vpc_cidr = "10.0.0.0/16"
  azs      = ["ap-southeast-2a", "ap-southeast-2b"]

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]
}

module "logging" {
  source       = "../../modules/logging"
  project_name = "VaultAWS"
  region       = "ap-southeast-2"
  alert_email  = "velio971@gmail.com"
}

module "iam" {
  source              = "../../modules/iam"
  project_name        = "VaultAWS"
  admin_principal_arn = "arn:aws:iam::107258763926:user/terraform-admin"
  region              = "ap-southeast-2"
}



