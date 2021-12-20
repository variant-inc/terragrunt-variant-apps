terraform_version_constraint = "~> 1.1.0"

locals {
  deploy_yaml = yamldecode(file("../project/deploy/api.yaml"))
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = get_env("TERRAGRUNT_S3_BUCKET")
    region         = get_env("AWS_DEFAULT_REGION")
    key            = "${local.deploy_yaml.octopus.space}/${local.deploy_yaml.octopus.group}/${local.deploy_yaml.name}/${path_relative_to_include()}/terraform.tfstate"
    encrypt        = true
    dynamodb_table = get_env("TERRAGRUNT_DYNAMO_TABLE")
  }
}

terraform {
  extra_arguments "varfiles" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]

    optional_var_files = [
      "${get_terragrunt_dir()}/terraform.tfvars.json"
    ]
  }
}

inputs = {
  aws_resource_name_prefix = "eng"
}
