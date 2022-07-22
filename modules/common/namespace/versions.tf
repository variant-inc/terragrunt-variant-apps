terraform {
  required_version = "~> 1.1"
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8"
    }
    null = {
      version = "~> 3.1.1"
    }
  }
}