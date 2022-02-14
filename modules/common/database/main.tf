data "aws_secretsmanager_secret_version" "database" {
  secret_id = "${var.cluster_name}-rds-creds"
}

locals {
  creds = jsondecode(data.aws_secretsmanager_secret_version.database.secret_string)
}

module "database" {
  source          = "github.com/variant-inc/terraform-postgres-database?ref=v1"
  count           = var.database_count
  create_database = var.create_database
  extensions      = var.extensions
  database_name   = var.database_name
  role_name       = var.role_name
  providers = {
    postgresql.this = postgresql
  }
}