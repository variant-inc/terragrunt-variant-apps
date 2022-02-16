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

dependency "database" {
  config_path = "../../common//database"
  mock_outputs = {
    database = ""
    username = ""
    password = ""
  }
}

terraform {
  source = "../../../modules/apps//api"
}

locals {
  deploy_yaml          = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
  chart_user_values    = try(local.deploy_yaml.chart, {})
  env_vars_user_values = try(local.deploy_yaml.envVars, {})
  env_vars = flatten(
    [for k, v in local.env_vars_user_values : [
      {
        name  = k
        value = v
      }
    ]]
  )
}

inputs = {
  chart_env_vars = concat(
    local.env_vars,
    dependency.buckets.outputs.env_vars,
    dependency.messaging.outputs.env_vars,
    dependency.database.outputs.env_vars
  )
  chart_values = [
    yamlencode(local.chart_user_values)
  ]
  policies = merge(
    dependency.buckets.outputs.policies,
    dependency.messaging.outputs.sns_topic_publish_policy,
    dependency.messaging.outputs.queue_receive_policy,
    dependency.database.outputs.policies

  )
  image                  = "064859874041.dkr.ecr.us-east-1.amazonaws.com/${local.deploy_yaml.image}"
  authentication_enabled = try(local.deploy_yaml.authentication, false)
  namespace              = dependency.namespace.outputs.namespace_name
}
