# Database - Postgres

- [Database - Postgres](#database---postgres)
  - [Examples](#examples)
    - [Create Database](#create-database)
    - [Create Read-Only User](#create-read-only-user)
    - [Create Database with Extensions](#create-database-with-extensions)
  - [Supported Attributes](#supported-attributes)
    - [Exposed Environment Variables](#exposed-environment-variables)

This document will allow you to provision a database + a database user

1. Create Database
2. Create Read-Only User
3. Create Database with Extensions

*If no bucket is needed, do not add `postgres` under `infrastructure`*

## Examples

### Create Database

```bash
infrastructure:
  postgres:
    - name: test_database
      role_name: test_user
      reference: test
```

The application will be deployed with the following `environnement variables`

```bash
BUCKET__test__host = "rds.variant-dev.drivevariant.com"
BUCKET__test__name = "test_database"
BUCKET__test__user = "test_user"
BUCKET__test__password = "test_password"
```

### Create Read-Only User

```bash
infrastructure:
  postgres:
    - name: test_database_2
      role_name: user1
      reference: test_user_role2
      read_only: true
```

The application will be deployed with the following `environnement variables`

```bash
BUCKET__test_user_role2__host = "rds.variant-dev.drivevariant.com"
BUCKET__test_user_role2__name = "test_database_2"
BUCKET__test_user_role2__user = "user1"
BUCKET__test_user_role2__password = "test_2_password"
```

### Create Database with Extensions

```bash
infrastructure:
  postgres:
    - name: test_database
      role_name: admin
      extensions: ["postgis"]
      reference: test
```

The application will be deployed with the following `environnement variables`

```bash
BUCKET__test__host = "rds.variant-dev.drivevariant.com"
BUCKET__test__name = "test_database"
BUCKET__test__user = "test_user"
BUCKET__test__password = "test_password"
```

## Supported Attributes

The following attributes should be added under

```bash
infrastructure:
  postgres:
```

[Inputs](../modules/common/postgres/README.md#inputs)

### Exposed Environment Variables

Below are the exposed env variables and can be referenced
in the code with below names.

| Env variable               | Description                          |
| -------------------------- | ------------------------------------ |
| POSTGRES__\<ref>__host     | Hostname of the database cluster     |
| POSTGRES__\<ref>__name     | Name of the Database                 |
| POSTGRES__\<ref>__user     | Name of the Role in the database     |
| POSTGRES__\<ref>__password | Password of the Role in the database |
