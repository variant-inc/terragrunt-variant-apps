include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

include "kubernetes_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/kubernetes.hcl"
}

dependency "namespace" {
  config_path = "${path_relative_from_include("root")}/common/namespace"
  mock_outputs = {
    namespace_name = ""
  }
}

dependency "tags" {
  config_path = "${path_relative_from_include("root")}/common/tags"
  mock_outputs = {
    tags = {}
  }
}

terraform {
  source = "${path_relative_from_include("root")}/../modules/common//postgres"
}

locals {
  deploy_yaml = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
}

inputs = {
  databases    = try(local.deploy_yaml.infrastructure.postgres, [])
  app_name     = local.deploy_yaml.name
  app_type     = try(local.deploy_yaml.api, false) != false || try(local.deploy_yaml.handler, false) != false
  namespace    = dependency.namespace.outputs.namespace_name
  service_port = try(local.deploy_yaml.api.service.port, try(local.depoy_yaml.handler.service.port, 80))
  labels = merge(
    {
      "app" : local.deploy_yaml.name,
      "revision" : local.deploy_yaml.git.version
    },
    {
      for k, v in dependency.tags.outputs.tags : "cloudops.io.${k}" => replace(v, " ", "-")
    }
  )
}
