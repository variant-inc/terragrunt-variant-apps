terraform {
  required_version = "~>1.0.0"
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
      version = "~> 3.0.0"
    }
  }
}

resource "null_resource" "create_namespace" {
  provisioner "local-exec" {
    working_dir = path.module
    command     = "chmod +x ./create_namespace.sh && ./create_namespace.sh ${var.cluster_name} ${var.namespace}"
  }
}
