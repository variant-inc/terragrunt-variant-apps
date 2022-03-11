include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

terraform {
  source = "${path_relative_from_include("root")}/../modules/common//messaging"
}

locals {
  deploy_yaml = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
}

inputs = {
  topics              = try(local.deploy_yaml.infrastructure.topics, {})
  topic_subscriptions = try(local.deploy_yaml.infrastructure.topic_subscriptions, {})
}

