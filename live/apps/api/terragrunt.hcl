include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "apps" {
  path           = find_in_parent_folders("apps.hcl")
  merge_strategy = "deep"
  expose         = true
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

terraform {
  source = "../../../modules/apps//api"
}

locals {
  deploy_yaml             = include.root.locals.deploy_yaml
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
    local.config_vars
  )
  chart_values = [
    yamlencode(local.chart_user_values),
    yamlencode({
      configMaps = concat(
        dependency.buckets.outputs.config_maps,
        dependency.postgres.outputs.config_maps,
        dependency.messaging.outputs.config_maps
      )
    })
  ]
  authentication_enabled = try(local.deploy_yaml.authentication, false)
}
