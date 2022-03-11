dependency "buckets" {
  config_path = "${get_terragrunt_dir()}/../../common/buckets"
  mock_outputs = {
    config_maps = []
    policies    = {}
  }
}

dependency "database" {
  config_path = "${get_terragrunt_dir()}/../../common//database"
  mock_outputs = {
    env_vars = []
    password = ""
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
    env_vars = []
  }
}

dependency "role" {
  config_path = "${get_terragrunt_dir()}/../../common/role"
  mock_outputs = {
    role_arn = ""
  }
}
