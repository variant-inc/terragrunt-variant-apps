output "config_maps" {
  value       = [for label, cm in kubernetes_config_map.postgres : cm.metadata[0].name]
  description = "Config Map for Postgres"
}

output "database_map" {
  value       = local.database_map
  description = "Database Map"
}

output "secret_ids" {
  value       = [for db in module.database : db.secret_id]
  description = "List of Secret IDs for Postgres in AWS SecretManager"
}