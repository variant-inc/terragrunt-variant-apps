include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

terraform {
  source = "../../../modules/common//okta_spa"
}

locals {
  deploy_yaml     = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
}

inputs = {
  name = local.create_database
  redirect_uris             = try(local.deploy_yaml.infrastructure.okta_spa.redirect_uris, null)
  post_logout_redirect_uris         = try(local.deploy_yaml.infrastructure.okta_spa.post_logout_redirect_uris, null)
  trusted_origins      = try(local.deploy_yaml.infrastructure.okta_spa.trusted_origins, [])
  issuer_mode       = try(local.deploy_yaml.infrastructure.okta_spa.issuer_mode, "ORG_URL")
  login_scopes = try(local.deploy_yaml.infrastructure.okta_spa.issuer_mode, null)
}