include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../_env/provider/aws.hcl"
}

include "octopus_variables" {
  path = "${path_relative_to_include()}/../_env/variables/octopus.hcl"
}

terraform {
  source = "../../modules//buckets"
}
