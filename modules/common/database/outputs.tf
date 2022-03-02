output "database" {
  value       = try(module.database[0].database, "")
  description = "Name of the Database"
}

output "user" {
  value       = try(module.database[0].user, "")
  description = "Name of the User"
}

output "password" {
  value       = try(module.database[0].password, "")
  sensitive   = true
  description = "Password of the User"
}

output "policies" {
  value = var.create_any ? { "data" : data.aws_iam_policy_document.policies[0] } : {}
}

output "env_vars" {
  description = "Environment variables for app use."
  value       = local.env_vars
}