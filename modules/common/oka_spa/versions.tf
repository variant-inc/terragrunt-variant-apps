terraform {
  required_version = ">=1.0.0"
  required_providers {
    okta = {
      source  = "okta/okta"
      version = ">= 3.20"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}