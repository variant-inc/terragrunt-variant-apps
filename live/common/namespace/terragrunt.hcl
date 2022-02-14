locals {
  root        = read_terragrunt_config(find_in_parent_folders())
  deploy_yaml = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

include "kubernetes_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/kubernetes.hcl"
}

terraform {
  source = "../../../modules/common//namespace"
}
