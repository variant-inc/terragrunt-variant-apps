locals {
  deploy_yaml = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
  skip_pg     = length(try(local.deploy_yaml.infrastructure.postgres, [])) > 0 ? false : true
}

inputs = {
  image     = local.deploy_yaml.git.image
  role_arn  = dependency.role.outputs.role_arn
  namespace = dependency.namespace.outputs.namespace_name
}

dependency "buckets" {
  config_path = "${get_terragrunt_dir()}/../../common/buckets"
  mock_outputs = {
    config_maps = []
    policies    = {}
  }
}

dependency "postgres" {
  config_path = local.skip_pg ? "${get_terragrunt_dir()}/../../common/mock" : "${get_terragrunt_dir()}/../../common/postgres"
  mock_outputs = {
    config_maps = []
  }
}

dependency "namespace" {
  config_path = "${get_terragrunt_dir()}/../../common/namespace"
  mock_outputs = {
    namespace_name = ""
  }
}

dependency "messaging" {
  config_path = "${get_terragrunt_dir()}/../../common/messaging"
  mock_outputs = {
    config_maps = []
  }
}

dependency "role" {
  config_path = "${get_terragrunt_dir()}/../../common/role"
  mock_outputs = {
    role_arn = ""
  }
}
