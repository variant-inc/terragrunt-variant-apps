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
    policies = {}
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
    env_vars                 = []
    sns_topic_publish_policy = {}
    queue_receive_policy     = {}
  }
}

dependency "role" {
  config_path = "../../common/role"
  mock_outputs = {
    role_arn = ""
  }
}

dependency "tags" {
  config_path = "../../common/tags"
  mock_outputs = {
    tags = {}
  }
}

terraform {
  source = "../../../modules/apps//cron"
}

locals {
  deploy_yaml             = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
  chart_user_values       = try(local.deploy_yaml.cron, {})
  create                  = local.chart_user_values == {} ? false : true
  config_vars_user_values = try(local.deploy_yaml.configVars, {})
  config_vars = flatten(
    [for k, v in local.config_vars_user_values : [
      {
        name  = k
        value = v
      }
    ]]
  )
}

inputs = {
  create = local.create
  chart_config_vars = concat(
    local.config_vars,
    dependency.buckets.outputs.env_vars,
    dependency.messaging.outputs.env_vars
  )
  chart_values = [
    yamlencode(local.chart_user_values)
  ]
  role_arn  = dependency.role.outputs.role_arn
  image     = local.deploy_yaml.git.image
  namespace = dependency.namespace.outputs.namespace_name
  tags      = dependency.tags.outputs.tags
}
