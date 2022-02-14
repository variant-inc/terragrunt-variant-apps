include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

terraform {
  source = "../../../modules/common//buckets"
}

locals {
  deploy_yaml = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
}

inputs = {
  managed  = try(local.deploy_yaml.infrastructure.buckets.managed, {})
  existing = try(local.deploy_yaml.infrastructure.buckets.existing, {})
}
