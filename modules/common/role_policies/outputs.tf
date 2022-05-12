output "policies" {
  value       = data.aws_iam_policy_document.role_policies
  description = "Custom role policies to attach"
}
