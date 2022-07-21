locals {
  database_map = { for db in var.databases : db.reference => db }
}

data "aws_secretsmanager_secret_version" "database" {
  secret_id = "${var.cluster_name}-rds-creds"
}

locals {
  creds = jsondecode(data.aws_secretsmanager_secret_version.database.secret_string)
}

module "database" {
  for_each        = local.database_map
  source          = "github.com/variant-inc/terraform-postgres-database?ref=v1.0"
  create_database = lookup(each.value, "read_only", false) == true ? false : true
  extensions      = lookup(each.value, "extensions", [])
  database_name   = each.value.name
  role_name       = each.value.role_name
  providers = {
    postgresql.this = postgresql
  }
}

resource "kubernetes_config_map" "postgres" {
  for_each = local.database_map

  metadata {
    name      = "${var.app_name}-postgres-${replace(each.key, "_", "-")}"
    namespace = var.namespace
    labels    = var.labels
  }

  data = {
    "DATABASE__${each.value.reference}__name"     = module.database[each.key].database
    "DATABASE__${each.value.reference}__user"     = module.database[each.key].user
    "DATABASE__${each.value.reference}__host"     = local.creds["host"]
    "DATABASE__${each.value.reference}__password" = module.database[each.key].password
  }
}

resource "kubernetes_manifest" "probe" {
  for_each = { for k, v in local.database_map : k => v if(
  var.app_type ? lookup(v, "create_probe", true) : false) }
  manifest = {
    "kind" : "Probe",
    "apiVersion" : "monitoring.coreos.com/v1",
    "metadata" : {
      "name" : "${each.value.name}"
      "namespace" : "${var.namespace}"
      "labels" : "${var.labels}"
    },
    "spec" : {
      "interval" : "10s",
      "module" : "http_2xx",
      "prober" : {
        "url" : "prometheus-blackbox-prometheus-blackbox-exporter.prometheus:9115"
      },
      "targets" : {
        "staticConfig" : {
          "static" : [
            "${var.app_name}.${var.namespace}.svc:${var.service_port}/${lookup(each.value, "db_endpoint", "health/db")}"
          ]
        }
      }
    }
  }
}
