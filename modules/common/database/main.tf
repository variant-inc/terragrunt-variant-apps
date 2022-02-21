data "aws_secretsmanager_secret_version" "database" {
  secret_id = "${var.cluster_name}-rds-creds"
}

locals {
  creds = jsondecode(data.aws_secretsmanager_secret_version.database.secret_string)
}


module "database" {
  source          = "github.com/variant-inc/terraform-postgres-database?ref=v1"
  create_database = var.create_database
  extensions      = var.extensions
  database_name   = var.db_name
  role_name       = var.role_name
  providers = {
    postgresql.this = postgresql
  }
}

data "aws_db_instance" "physical_db" {
  db_instance_identifier = var.cluster_name
}

data "aws_iam_policy_document" "policies" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    resources = [
      "arn:aws:rds-db:${var.aws_region}:${data.aws_caller_identity.current.account_id}:dbuser:${data.aws_db_instance.physical_db.resource_id}/${var.role_name}"
    ]
    actions = [
      "rds-db:connect"
    ]
  }
}

locals {
  env_vars = [
      {
        name  = "DATABASE__NAME"
        value = module.database.database
      },
      {
        name  = "DATABASE__USER"
        value = module.database.user
      }
  ]
}