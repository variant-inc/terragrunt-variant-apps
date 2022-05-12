# Dynamo DB

- [Dynamo DB](#dynamo-db)
  - [Examples](#examples)
    - [Create Dynamo DB](#create-dynamo-db)
    - [Add Existing Dynamo DB Using Name](#add-existing-dynamo-db-using-name)
    - [Add Existing Dynamo DB from cross account](#add-existing-dynamo-db-from-cross-account)
    - [Mix and Match](#mix-and-match)
  - [Supported Attributes](#supported-attributes)
  - [Exposed Environment Variables](#exposed-environment-variables)

In this guide, you will learn

1. Create new Dynamo db tables
2. Use Existing Dynamo db tables
   1. By table name in same account
   2. By table name in different account

*If no dynamodb table is needed, do not add `dynamodb` under `infrastructure`*

## Examples

### Create Dynamo DB

Consider that the infrastructure created below is for

- name: hello-world
- reference: demo

```bash
infrastructure:
  dynamodb:
    managed:
      - name: hello
        reference: hw
        hash_key: id
        attributes:
          - name: id
            type: S
```

The application will be deployed with the following `environnement variables`

```bash
DYNAMODB__hello__arn = "arn:aws:dynamodb:us-east-1:123456789:table/hello"
DYNAMODB__hello = "hello"
```

### Add Existing Dynamo DB Using Name

To use the DynamoDB created in the above example in another project.

```bash
infrastructure:
  dynamodb:
    existing:
      - name: test
        reference: hw

```

The application will be deployed with the following `environnement variables`

```bash
DYNAMODB__hw__arn = "arn:aws:dynamodb:::table/test"
DYNAMODB__hw__name = "test"
```

### Add Existing Dynamo DB from cross account

```bash
infrastructure:
  dynamodb:
    existing:
      - reference: hw
        cross_account_arn: arn:aws:dynamodb:us-east-1:123456789:table/test
```

`full_name` is the full name of the bucket as provided in AWS console.

The application will be deployed with the following `environnement variables`

```bash
DYNAMODB__hw__arn = "arn:aws:dynamodb:us-east-1:123456789:table/test"
```

### Mix and Match

```bash
infrastructure:
  dynamodb:
    managed:
      - name: hello
        reference: hw
        hash_key: id
        attributes:
          - name: id
            type: S
    existing:
      - name: test
        reference: blah
      - reference: hw
        cross_account_arn: arn:aws:dynamodb:us-east-1:123456789:table/test1
```

The application will be deployed with the following `environnement variables`

```bash
DYNAMODB__hello__arn = "arn:aws:dynamodb:us-east-1:123456789:table/hello"
DYNAMODB__hello = "hello"

DYNAMODB__blah__arn = "arn:aws:dynamodb:::table/test"
DYNAMODB__blah__name = "test"

DYNAMODB__hw__arn = "arn:aws:dynamodb:us-east-1:123456789:table/test1"
```

## Supported Attributes

The following attributes should be added under

```bash
infrastructure:
  dynamodb:
```

[Inputs](../modules/common/dynamodb/README.md#inputs)

## Exposed Environment Variables

Below are the exposed env variables and can be referenced
in the code with below names.

| Env variable                 | Description                |
| ---------------------------- | -------------------------- |
| DYNAMODB__\<reference>__name | Name of the Dynamodb table |
| DYNAMODB__\<reference>__arn  | Table ARN                  |
