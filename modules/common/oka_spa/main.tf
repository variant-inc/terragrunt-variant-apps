module "spa_oauth_app" {
  source                     = "git::https://github.com/variant-inc/terraform-okta-oauth-web-app.git?ref=v1"
  type                       = "browser"
  environment                = var.environment
  name                       = var.name
  token_endpoint_auth_method = "none"
  grant_types                = ["authorization_code", "implicit"]
  redirect_uris              = var.redirect_uris
  post_logout_redirect_uris  = var.post_logout_redirect_uris
  trusted_origins            = var.trusted_origins
  response_types             = ["code", "id_token", "token"]
  app_user_group_rule_groups = ["Everyone"]
  consent_method             = "REQUIRED"
  issuer_mode                = var.issuer_mode
  login_scopes               = var.login_scopes
  user_tags                  = var.user_tags
  octopus_tags               = var.octopus_tags
}
