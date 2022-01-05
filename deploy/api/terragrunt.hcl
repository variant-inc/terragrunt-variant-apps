include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../_env/provider/aws.hcl"
}

include "kubernetes_provider" {
  path = "${path_relative_to_include()}/../_env/provider/kubernetes.hcl"
}

include "helm_provider" {
  path = "${path_relative_to_include()}/../_env/provider/helm.hcl"
}

dependency "buckets" {
  config_path = "../buckets"
  mock_outputs = {
    chart_values = ""
    policies = {}
  }
}

# dependency "namespace" {
#   config_path = "../namespace"
#   mock_outputs = {
#     namespace_name = "test"
#   }
# }

terraform {
  source = "../../modules//api"
}

locals {
  chart_user_values = try(
    yamldecode(file("${path_relative_from_include("root")}/../../project/deploy/api.yaml")).chart,
    ""
  )
}

inputs = {
  chart_values = [
    dependency.buckets.outputs.chart_values,
    yamlencode(local.chart_user_values)
  ]
  policies = merge(
    dependency.buckets.outputs.policies,
    {}
  )
  # namespace = dependency.namespace.outputs.namespace_name
}
