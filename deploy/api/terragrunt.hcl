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
    chart_values : ""
  }
}

terraform {
  source = "../../modules//api"
}

locals {
  chart_defaults = yamlencode({
    revision = "0.0.1"
    istio = {
      ingress = {
        host = "dev-drivevariant.com"
      }
    }
    deployment = {
      image = {
        tag = "064859874041.dkr.ecr.us-east-2.amazonaws.com/jazz-backend/api:0.1.0-cloud-1105-0001.121"
      }
    }
    service = {
      targetPort = 5001
    }
  })
}

inputs = {
  chart_value_overrides = [
    local.chart_defaults,
    dependency.buckets.outputs.chart_values
  ]
}
