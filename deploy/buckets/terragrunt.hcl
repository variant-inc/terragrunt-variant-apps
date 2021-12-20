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
  file_path    = "${path_relative_from_include("root")}/../../project/deploy/api.yaml"
  bucket_input = try(yamldecode(file(local.file_path)).infrastructure.buckets, null)
}

inputs = {
  buckets = local.bucket_input
}
