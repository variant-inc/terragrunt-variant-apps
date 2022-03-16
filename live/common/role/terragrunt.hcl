include "root" {
  path = find_in_parent_folders()
}

include "aws_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/aws.hcl"
}

include "kubernetes_provider" {
  path = "${path_relative_to_include()}/../../_env/provider/kubernetes.hcl"
}

dependency "buckets" {
  config_path = "${path_relative_from_include("root")}/common/buckets"
  mock_outputs = {
    policies = {}
  }
}

dependency "namespace" {
  config_path = "${path_relative_from_include("root")}/common/namespace"
  mock_outputs = {
    namespace_name = ""
  }
}

dependency "database" {
  config_path = "${path_relative_from_include("root")}/common//database"
  mock_outputs = {
    policies = {}
  }
}

dependency "messaging" {
  config_path = "${path_relative_from_include("root")}/common/messaging"
  mock_outputs = {
    sns_topic_publish_policy = {}
    queue_receive_policy     = {}
  }
}

terraform {
  source = "${path_relative_from_include("root")}/../modules/common//role"
}

inputs = {
  policies = merge(
    dependency.buckets.outputs.policies,
    dependency.messaging.outputs.sns_topic_publish_policy,
    dependency.messaging.outputs.queue_receive_policy,
    dependency.database.outputs.policies
  )
  namespace = dependency.namespace.outputs.namespace_name
}
