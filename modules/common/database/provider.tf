provider "postgresql" {
  host            = local.creds["host"]
  username        = local.creds["username"]
  password        = local.creds["password"]
  connect_timeout = 30
  superuser       = false
}
