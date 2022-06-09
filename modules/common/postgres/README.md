<!-- markdownlint-disable MD033 MD013 MD041 -->

## DX Inputs

### postgres

| Key          | Type         | Default | Description                          | Example       | Required |
| ------------ | ------------ | ------- | ------------------------------------ | ------------- | -------- |
| name         | string       |         | Name of the database to be created   | test-database | yes      |
| reference    | string       |         | Short name to reference the database | test          | yes      |
| role_name    | string       |         | Name of the role                     | admin         | yes      |
| read_only    | bool         |         | Create database with read-only-user  | true          | optional |
| extensions   | list(string) | [ ]     | Array of extensions                  | ["postgis"]   | optional |
| create_probe | bool         |         | Create database probe                | true          | optional |
| db_endpoint  | list(string) |         | Endpoint of database health check    | health/db     | optional |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.66 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | ~> 1.14 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_database"></a> [database](#module\_database) | github.com/variant-inc/terraform-postgres-database | v1.0 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.postgres](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_manifest.probe](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [aws_secretsmanager_secret_version.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Release name of the app | `string` | n/a | yes |
| <a name="input_app_type"></a> [app\_type](#input\_app\_type) | Returns true if the application type is api or handler | `bool` | n/a | yes |
| <a name="input_databases"></a> [databases](#input\_databases) | List of Postgres Databases to create. [ name, reference, role\_name, read\_only (Optional: false), extensions (Optional: []) ] | `any` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Map of Labels to be applied to config maps | `map(string)` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name of the app | `string` | n/a | yes |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | Exposed Port of application's service | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_maps"></a> [config\_maps](#output\_config\_maps) | Config Map for Postgres |
| <a name="output_database_map"></a> [database\_map](#output\_database\_map) | Database Map |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
