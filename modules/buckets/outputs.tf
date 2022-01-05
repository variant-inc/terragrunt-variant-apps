output "chart_values" {
  value = local.chart_values
}

output "all_buckets" {
  value = local.all_buckets
}

output "policies" {
  value = data.aws_iam_policy_document.policies
}
