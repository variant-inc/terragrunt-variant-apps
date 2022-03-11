include "root" {
  path   = find_in_parent_folders()
  expose = true
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

terraform {
  source = "${path_relative_from_include("root")}/../modules/common//buckets"
}

locals {
  deploy_yaml = include.root.locals.deploy_yaml
}

inputs = {
  managed   = try(local.deploy_yaml.infrastructure.buckets.managed, [])
  existing  = try(local.deploy_yaml.infrastructure.buckets.existing, [])
  app_name  = local.deploy_yaml.name
  namespace = dependency.namespace.outputs.namespace_name
}
