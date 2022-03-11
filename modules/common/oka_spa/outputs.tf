output "client_id" {
  description = "The client ID of the Okta application."
  value       = module.spa_oauth_app.client_id
}