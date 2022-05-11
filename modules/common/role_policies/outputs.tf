output "policies" {
  value = tolist([
    for policy in aws_iam_policy.role_policies
  ])
}
