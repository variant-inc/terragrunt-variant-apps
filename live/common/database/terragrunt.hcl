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
  create_any      = try(local.deploy_yaml.infrastructure.database, false) == false ? false : true
  create_database = try(local.deploy_yaml.infrastructure.database.create_database, false) 

}

inputs = {
  create_database = local.create_database
  create_any      = local.create_any
  db_name         = try(local.deploy_yaml.infrastructure.database.db_name, "")
  extensions      = try(local.deploy_yaml.infrastructure.database.extensions, [])
  role_name       = try(local.deploy_yaml.infrastructure.database.name, "")
}
