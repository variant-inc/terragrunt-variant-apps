output "database" {
  value       = module.database.database
  description = "Name of the Database"
}

output "user" {
  value       = module.database.user
  description = "Name of the User"
}

output "password" {
  value       = module.database.password
  sensitive   = true
  description = "Password of the User"
}

output "policies" {
  value = {"${module.database.database}-policies" : data.aws_iam_policy_document.policies}
}

output "env_vars" {
  description = "Environment variables for app use."
  value       = local.env_vars
}