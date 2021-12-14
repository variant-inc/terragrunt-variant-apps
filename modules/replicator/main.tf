resource "aws_dynamodb_table_item" "iaac_replicator" {
  table_name = "replicator_octo_projects"
  hash_key   = "Space"
  range_key  = "Project"

  item = <<ITEM
{
  "Space": {
    "S": "<%= $global:SPACE_NAME %>"
  },
  "Project": {
    "S": "<%= $global:PROJECT_NAME %>"
  },
  "GithubRepository": {
    "S": "<%= $env:GITHUB_REPOSITORY %>"
  },
  "GithubUser": {
    "S": "<%= $env:GITHUB_ACTOR %>"
  },
  "Version": {
    "S": "<%= $env:VERSION %>"
  },
  "Image": {
    "S": "<%= $env:IMAGE_NAME %>"
  },
  "IsInfrastructure": {
    "S": "<%= $env:IS_INFRASTRUCTURE %>"
  }
}
ITEM

}

resource "kubernetes_config_map" "iaac_replicator" {
  metadata {
    name      = "${var.name}-iaac-replicator"
    namespace = data.kubernetes_namespace.namespace.metadata[0].name
    labels = {
      "cloudops.iaac/replicator" : "v1"
    }
  }

  data = {
    "Space" : ""
    "Project" : ""
    "GithubRepository" : ""
    "GithubUser" : "",
    "Version" : "",
    "Image" : "",
    "IsInfrastructure" : ""
  }
}
