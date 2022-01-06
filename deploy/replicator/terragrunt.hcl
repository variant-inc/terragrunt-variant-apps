include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../_env/provider/aws.hcl"
}

terraform {
  source = "../../modules//replicator"
}

locals {
  deploy_yaml = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
  git_inputs  = local.deploy_yaml.git 
}

inputs = {
  release_data = {
    space             = local.deploy_yaml.octopus.space
    project           = local.deploy_yaml.name
    repository        = local.git_inputs.repository
    user              = local.git_inputs.user
    version           = local.git_inputs.version
    image             = local.git_inputs.image
    is_infrastructure = local.git_inputs.isinfrastructure
  }
}
