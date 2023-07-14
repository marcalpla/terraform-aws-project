terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }
  }
  backend "s3" {
    bucket  = "terraform-aws-project-backend"
    region  = "eu-west-1"
    profile = "default"
  }
  required_version = ">= 1.5.3"
}

provider "aws" {
  region  = var.region
  profile = "default"
}
