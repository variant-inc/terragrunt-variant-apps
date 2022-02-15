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
  deploy_yaml     = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
  create_database = try(local.deploy_yaml.infrastructure.database.create_database, false)
  database_count  = local.create_database == true ? 1 : 0
}

inputs = {
  database_count  = local.database_count
  create_database = local.create_database
  database_name   = try(local.deploy_yaml.infrastructure.database.db_name, "")
  extensions      = try(local.deploy_yaml.infrastructure.database.extensions, [])
  role_name       = try(local.deploy_yaml.infrastructure.database.name, "")
}
