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
  source = "../../../modules/apps//handler"
}

locals {
  deploy_yaml       = include.root.locals.deploy_yaml
  chart_user_values = try(local.deploy_yaml.handler, {})
  create            = local.chart_user_values == {} ? false : true
}

inputs = {
  create = local.create
  chart_values = [
    yamlencode(local.chart_user_values),
    yamlencode({
      awsSecrets = concat(
        dependency.postgres.outputs.secret_ids,
        try(local.deploy_yaml.api.awsSecrets, {})
      )
    }),
    yamlencode({
      configMaps = concat(
        dependency.buckets.outputs.config_maps,
        dependency.postgres.outputs.config_maps,
        dependency.messaging.outputs.config_maps
      )
    })
  ]
  tags = dependency.tags.outputs.tags
}
