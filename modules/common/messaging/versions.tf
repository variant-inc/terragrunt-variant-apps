terraform {
  required_version = "~> 1.1"
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8"
    }
  }
}