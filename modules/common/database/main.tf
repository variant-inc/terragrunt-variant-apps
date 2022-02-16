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

data "aws_iam_policy_document" "policies" {
  count   = var.database_count
  version = "2012-10-17"

  statement {
    effect = "Allow"
    resources = [
      "arn:aws:rds-db:${var.aws_region}:${data.aws_caller_identity.current.account_id}:dbuser:${module.database[count.index].database_id[count.index]}/${var.role_name}"
    ]
    actions = [
      "rds-db:connect"
    ]
  }
}

locals {
  env_vars = [for label, database in module.database :
    [
      {
        name  = "database__${label}__name"
        value = database.database
      },
      {
        name  = "user__${label}__name"
        value = database.user
      }
    ]
  ]

}