# include "postrgresql_aws_provider" {
#   path = "./aws.hcl"
# }

# data "aws_secretsmanager_secret_version" "database" {
#   secret_id = "${var.cluster_name}-rds-creds"
# }

# locals {
#   creds = jsondecode(data.aws_secretsmanager_secret_version.database.secret_string)
# }

provider "postgresql" {
  host            = local.creds["host"]
  username        = local.creds["username"]
  password        = local.creds["password"]
  connect_timeout = 30
  superuser       = false
}