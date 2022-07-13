terraform {
  required_version = "~> 1.1"
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.14"

      configuration_aliases = [postgresql.this]
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8"
    }
  }
}