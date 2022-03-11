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
  source = "${path_relative_from_include("root")}/../modules/common//replicator"
}

locals {
  deploy_yaml = include.root.locals.deploy_yaml
  git_inputs  = local.deploy_yaml.git
}

inputs = {
  namespace = dependency.namespace.outputs.namespace_name
  release_data = {
    space             = local.deploy_yaml.octopus.space
    project           = local.deploy_yaml.name
    repository        = local.git_inputs.repository
    user              = local.git_inputs.user
    version           = local.git_inputs.version
    image             = local.git_inputs.image
    is_infrastructure = local.git_inputs.isinfrastructure
  }
}
