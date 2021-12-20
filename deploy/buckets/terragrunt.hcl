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
  bucket_input = yamldecode(file("${path_relative_from_include("root")}/../../project/deploy/api.yaml")).infrastructure.buckets
}

inputs = {
  buckets = local.bucket_input
}
