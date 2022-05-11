include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

terraform {
  source = "${path_relative_from_include("root")}/../modules/common//role_policies"
}

locals {
  deploy_yaml = include.root.locals.deploy_yaml
}

inputs = {
  policies = try(local.deploy_yaml.infrastructure.role_policies, [])
}
