Create database to optionally create and reference in your deployment. This need to be added under infrastructure section with attribute database and support attributes.

Supported attributes. See [database](https://github.com/variant-inc/terragrunt-variant-apps/blob/master/modules/common/database/README.md)  for valid attribute values. Only the attributes listed here are supported

Here is the example sample to add database to application

```bash
  database:
    create_database: true
    db_name: "sample-db"
    extensions: ["postgis"]
    name: "Sample-test"
```
Here is the sample format to add database to the application.

```bash
  database:
    create_database: true or false
    db_name: "DB_NAME"
    extensions: ["EXTENSIONS",..]
    name: "SAMPLE_NAME"
```

### Supported attributes under database

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|  cluster_name | Cluster name | `string` | `"variant-dev"` | no |
|  create_database | To create database | `any` | n/a | yes |
|  database_count| Count | `number` | n/a | no |
|  database_name | Database name | `any` | n/a | yes |
|  extensions | db extensions | `list(string)` | n/a | yes |
|  name | Role name | `any` | n/a | no |

### Exposed environment variables

Below are the exposed env variables and can be referenced  in the code with below names.

| Env variable       | Description                       |
|--------------------|-----------------------------------|
| DATABASE__host     | Env variable to database host     |
| DATABASE__name     | Env variable to database name     |
| DATABASE__user     | Env variable to database user     |
| DATABASE__password | Env variable to database password |