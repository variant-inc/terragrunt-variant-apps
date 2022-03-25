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

terraform {
  source = "${path_relative_from_include("root")}/../modules/common//messaging"
}

locals {
  deploy_yaml = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
}

inputs = {
  app_name            = local.deploy_yaml.name
  topics              = try(local.deploy_yaml.infrastructure.sns_topics, {})
  topic_subscriptions = try(local.deploy_yaml.infrastructure.sns_sqs_subscriptions, {})
  namespace           = dependency.namespace.outputs.namespace_name

}

