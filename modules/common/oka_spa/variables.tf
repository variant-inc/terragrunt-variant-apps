variable "name" {
  description = "Name of application using the Okta app."
  type        = string
}

variable "environment" {
  description = "Environment of Okta app."
  type        = string
}

variable "redirect_uris" {
  description = "Login redirect URIs."
  type        = list(string)
}

variable "post_logout_redirect_uris" {
  description = "Logout redirect URIs."
  type        = list(string)
}

variable "trusted_origins" {
  description = "Urls to add as trusted origins to Okta Security"
  type        = list(string)
}

variable "login_scopes" {
  description = "List of scopes to use for the request. Valid values: \"openid\", \"profile\", \"email\", \"address\", \"phone\". Required when login_mode is NOT DISABLED."
  type        = list(string)
}

variable "okta_org_name" {
  description = "Okta org name to configure the Okta provider. Availble in Okta Variables Library Set."
  type        = string
}

variable "okta_base_url" {
  description = "Okta base url to configure the Okta provider. Availble in Okta Variables Library Set."
  type        = string
}

variable "okta_api_token" {
  description = "Okta api token to configure the Okta provider. Availble in Okta Variables Library Set."
  type        = string
}

variable "user_tags" {
  description = "Tags set by User"
  type        = map(string)
}

variable "octopus_tags" {
  description = "Tags set by Octopus"
  type        = map(string)
}