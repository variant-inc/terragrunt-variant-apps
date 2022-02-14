include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

terraform {
  source = "../../../modules/common//database"
}

locals {
  deploy_yaml    = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
  db             = try(local.deploy_yaml.infrastructure.db, { "count" : 0 })
  create_any     = try(local.db, {}) == {} ? true : false
  database_count = local.create_any == true ? 1 : 0
}

inputs = {
  create_database = true
  database_count  = local.database_count
  database_name   = try(local.db.db_name, "")
  extensions      = try(local.db.extensions, [])
  role_name       = try(local.deploy_yaml.name, "")
}
