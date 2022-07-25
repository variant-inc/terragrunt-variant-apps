# output "config_maps" {
#   value       = [for label, cm in kubernetes_config_map.postgres : cm.metadata[0].name]
#   description = "Config Map for Postgres"
# }

output "secret_names" {
  value       = [for label, s in aws_secretsmanager_secret.postgres : {name = s.name}]
  description = "Secret name for Postgres"
}

output "database_map" {
  value       = local.database_map
  description = "Database Map"
}
