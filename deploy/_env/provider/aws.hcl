dependency "tags" {
  config_path = "${path_relative_from_include()}/../../tags"
}

generate "provider_aws" {
  path      = "provider_aws.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  default_tags {
    tags = ${dependency.tags.outputs.tags}
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

EOF
}
