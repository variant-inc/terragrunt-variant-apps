terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8"
    }
  }
}

data "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "aws_dynamodb_table_item" "iaac_replicator" {
  table_name = "replicator_octo_projects"
  hash_key   = "Space"
  range_key  = "Project"

  item = <<ITEM
{
  "Space": {
    "S": "${var.release_data.space}"
  },
  "Project": {
    "S": "${var.release_data.project}"
  },
  "GithubRepository": {
    "S": "${var.release_data.repository}"
  },
  "GithubUser": {
    "S": "${var.release_data.user}"
  },
  "Version": {
    "S": "${var.release_data.version}"
  },
  "Image": {
    "S": "${var.release_data.image}"
  },
  "IsInfrastructure": {
    "S": "${var.release_data.is_infrastructure}"
  }
}
ITEM

}

resource "kubernetes_config_map" "iaac_replicator" {
  metadata {
    name      = "${var.release_data.project}-iaac-replicator"
    namespace = data.kubernetes_namespace.namespace.metadata[0].name
    labels = {
      "cloudops.iaac/replicator" : "v1"
    }
  }

  data = {
    "Space" : "${var.release_data.space}"
    "Project" : "${var.release_data.project}"
    "GithubRepository" : "${var.release_data.repository}"
    "GithubUser" : "${var.release_data.user}"
    "Version" : "${var.release_data.version}"
    "Image" : "${var.release_data.image}"
    "IsInfrastructure" : "${var.release_data.is_infrastructure}"
  }
}
