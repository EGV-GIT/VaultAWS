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
  region = var.region
}

module "vpc" {
  source       = "../../modules/vpc"
  project_name = var.project_name
  region       = var.region

  vpc_cidr = var.vpc_cidr
  azs      = var.azs

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "logging" {
  source       = "../../modules/logging"
  project_name = var.project_name
  region       = var.region
  alert_email  = var.alert_email
}

module "iam" {
  source              = "../../modules/iam"
  project_name        = var.project_name
  admin_principal_arn = var.admin_principal_arn
  region              = var.region
}
