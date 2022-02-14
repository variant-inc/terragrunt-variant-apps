dependency "tags" {
  config_path = "${path_relative_from_include()}/../../common/tags"
  mock_outputs = {
    tags = {}
  }
}

generate "provider_aws" {
  path      = "provider_aws.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "aws_tags" {
  type = map(string)
}

provider "aws" {
  default_tags {
    tags = var.aws_tags
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

EOF
}

inputs = {
  aws_tags = dependency.tags.outputs.tags
}
