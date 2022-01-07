locals {
  root = read_terragrunt_config(find_in_parent_folders())
  merged_config = merge(
    local.root.remote_state.config,
    {
      key = "${local.root.locals.deploy_yaml.octopus.space}/${local.root.locals.deploy_yaml.octopus.group}/namespace"
    }
  )
  deploy_yaml  = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
}

remote_state = merge(
  local.root.remote_state,
  {
    config = local.merged_config
  }
)

include "aws_provider" {
  path = "${path_relative_to_include()}/../_env/provider/aws.hcl"
}

include "kubernetes_provider" {
  path = "${path_relative_to_include()}/../_env/provider/kubernetes.hcl"
}

terraform {
  source = "../../modules//namespace"
}

inputs = {
  create_namespace = try(local.deploy_yaml.manage_namespace, true)
}
