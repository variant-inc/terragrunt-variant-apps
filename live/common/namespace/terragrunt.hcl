include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

include "kubernetes_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/kubernetes.hcl"
}

locals {
  deploy_yaml = include.root.locals.deploy_yaml
}

terraform {
  source = "${path_relative_from_include("root")}/../modules/common//namespace"
}

inputs = {
  namespace = local.deploy_yaml.octopus.group
}
