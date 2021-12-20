include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../_env/provider/aws.hcl"
}

terraform {
  source = "../../modules//buckets"
}

locals {
  yaml_input   = yamldecode(file("${path_relative_from_include("root")}/../../project/deploy/api.yaml"))
  bucket_input = try(local.yaml_input.infrastructure.buckets, null)
}

inputs = {
  bucket_config = local.bucket_input
}
