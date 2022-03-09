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
  config_path = "../../common/namespace"
  mock_outputs = {
    namespace_name = ""
  }
}

terraform {
  source = "../../../modules/common//buckets"
}

locals {
  deploy_yaml = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
}

inputs = {
  managed               = try(local.deploy_yaml.infrastructure.buckets.managed, [])
  existing              = try(local.deploy_yaml.infrastructure.buckets.existing, {})
  app_name              = local.deploy_yaml.name
  namespace             = dependency.namespace.outputs.namespace_name
  existing_from_project = try(local.deploy_yaml.infrastructure.buckets.existing_from_project, {})
}
