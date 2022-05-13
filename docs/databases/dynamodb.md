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
DYNAMODB__hw__arn = "arn:aws:dynamodb:us-east-1:123456789:table/hello"
DYNAMODB__hw = "hello"
```

### Add Existing Dynamo DB Using Name

To use the DynamoDB created in the same account. Just need to add table `name` or `arn`  and `reference` to use with the app and DX will create config map to add the table.

```bash
infrastructure:
  dynamodb:
    existing:
      - name: test
        reference: hw
      - arn: arn:aws:dynamodb:us-east-1:123456789:table/test1
        reference: hw1

```

The application will be deployed with the following `environnement variables`

```bash
DYNAMODB__hw__arn = "arn:aws:dynamodb:::table/test"
DYNAMODB__hw__name = "test"

DYNAMODB__hw1__arn = "arn:aws:dynamodb:us-east-1:123456789:table/test1"
```

### Add Existing Dynamo DB from cross account

To use the DynamoDB created in different account. Just need to add `arn` and reference to use with the app and DX will create config map with table arn and update the role policy to have required access.

```bash
infrastructure:
  dynamodb:
    existing:
      - reference: hw
        arn: arn:aws:dynamodb:us-east-1:123456789:table/test
```

`arn` is the table arn as provided in AWS console.

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
      - arn: arn:aws:dynamodb:us-east-1:123456789:table/test1
        reference: hw1
      - reference: foo
        arn: arn:aws:dynamodb:us-east-1:987654321:table/test2
```

The application will be deployed with the following `environnement variables`

```bash
DYNAMODB__hello__arn = "arn:aws:dynamodb:us-east-1:123456789:table/hello"
DYNAMODB__hello = "hello"

DYNAMODB__blah__arn = "arn:aws:dynamodb:::table/test"
DYNAMODB__blah__name = "test"

DYNAMODB__hw1__arn = "arn:aws:dynamodb:us-east-1:123456789:table/test1"

DYNAMODB__foo__arn = "arn:aws:dynamodb:us-east-1:987654321:table/test2"
```

## Supported Attributes

The following attributes should be added under

```bash
infrastructure:
  dynamodb:
```

[Inputs](../../modules/common/dynamodb/README.md#inputs)

## Exposed Environment Variables

Below are the exposed env variables and can be referenced
in the code with below names.

| Env variable                 | Description                |
| ---------------------------- | -------------------------- |
| DYNAMODB__\<reference>__name | Name of the Dynamodb table |
| DYNAMODB__\<reference>__arn  | Table ARN                  |
