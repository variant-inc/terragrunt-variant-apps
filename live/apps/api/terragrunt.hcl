include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

include "kubernetes_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/kubernetes.hcl"
}

include "helm_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/helm.hcl"
}

dependency "buckets" {
  config_path = "../../common/buckets"
  mock_outputs = {
    env_vars = []
  }
}

dependency "database" {
  config_path = "../../common//database"
  mock_outputs = {
    env_vars = []
    password = ""
  }
}

dependency "namespace" {
  config_path = "../../common/namespace"
  mock_outputs = {
    namespace_name = ""
  }
}

dependency "messaging" {
  config_path = "../../common/messaging"
  mock_outputs = {
    env_vars = []
  }
}

dependency "role" {
  config_path = "../../common/role"
  mock_outputs = {
    role_arn = ""
  }
}

terraform {
  source = "../../../modules/apps//api"
}

locals {
  deploy_yaml             = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
  chart_user_values       = try(local.deploy_yaml.api, {})
  config_vars_user_values = try(local.deploy_yaml.configVars, {})
  config_vars = flatten(
    [for k, v in local.config_vars_user_values : [
      {
        name  = k
        value = v
      }
    ]]
  )
  create = local.chart_user_values == {} ? false : true
}

inputs = {
  create = local.create
  chart_config_vars = concat(
    local.config_vars,
    dependency.buckets.outputs.env_vars,
    dependency.messaging.outputs.env_vars,
    dependency.database.outputs.env_vars
  )
  chart_values = [
    yamlencode(local.chart_user_values)
  ]
  role_arn               = dependency.role.outputs.role_arn
  image                  = local.deploy_yaml.git.image
  authentication_enabled = try(local.deploy_yaml.authentication, false)
  namespace              = dependency.namespace.outputs.namespace_name
}
