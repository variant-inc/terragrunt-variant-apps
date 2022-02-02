# Terragrunt Variant Apps

## Testing

1. Determine the destination Octopus Space
   * Find the Variable Set "Terraform State Backup"
   * Set the environment variable `TERRAGRUNT_S3_BUCKET` to be the value of `S3_BUCKET`
   * Set the environment variable `TERRAGRUNT_DYNAMO_TABLE` to be the value of `DYNAMO_DB_TABLE`
2. Create a YAML following the [YAML Spec](#yaml-spec)
3. Set the environment variable `VARIANT_DEPLOY_YAML_LOCATION` to the location of the YAML

## YAML Spec

### Main Deploy YAML

| Property | Type | Required | Default |
| --- | --- | --- | --- |
| name | string | true | N/A |
| octopus | [Octopus](#octopus) | true | N/A |
| authentication | bool | false | false |
| infrastructure | [Infrastructure](#infrastructure) | false | N/A |
| chart | map | false | N/A |

### Object Reference

#### Octopus

| Property | Type | Required | Default |
| --- | --- | --- | --- |
| space | string | true | N/A |
| group | string | true | N/A |

#### Infrastructure

| Property | Type | Required | Default |
| --- | --- | --- | --- |
| buckets | [Buckets](modules/buckets/README.md#inputs) | false | N/A |
| topics | [Topics](modules/messaging/README.md#inputs) | false | N/A |
| topic_subscriptions | [Topic Subscriptions](modules/messaging/README.md#inputs) | false | N/A |

## Examples

### Deploy YAML

```yaml
name: demo-python-flask-variant-api
octopus:
  space: DataScience
  group: demo
envVars:
  special-key: 6576v58fq-v23r-f3r-23fgr2-gf
```

### Github Workflow

```yaml
name: Build & Push to Octopus
on:
  push:

env:
  MASTER_BRANCH: master
  AWS_REGION: us-east-1
  AWS_DEFAULT_REGION: us-east-1
  ECR_REPOSITORY: demo/python-flask-variant-api

jobs:
  build:
    name: Build Image and Push to Octo
    runs-on: [eks]
    steps:
      - name: Checkout Code
        uses: actions/checkout@v2
        with:
          fetch-depth: 0

      - name: Lazy Setup
        uses: variant-inc/actions-setup@v1
        id: lazy-setup

      - name: Lazy action steps
        id: lazy-action
        uses: variant-inc/actions-python@v1
        with:
          dockerfile_dir_path: "."
          ecr_repository: ${{ env.ECR_REPOSITORY }}
          test_framework: pytest

      - name: Lazy Action Octopus
        uses: variant-inc/actions-octopus@v3-beta
        with:
          default_branch: ${{ env.MASTER_BRANCH }}
          version: ${{ steps.lazy-setup.outputs.image_version }}
          package_read_token: ${{ secrets.PKG_READ }}
          ecr_repository: ${{ env.ECR_REPOSITORY }}
```
