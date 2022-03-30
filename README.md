# Variant Apps Terragrunt Module

Contents

- [Variant Apps Terragrunt Module](#variant-apps-terragrunt-module)
  - [Setup github workflow](#setup-github-workflow)
  - [Define Variant Apps YAML file](#define-variant-apps-yaml-file)

## Setup github workflow

Variant Apps Terragrunt Module is available for use with actions-octopus =< v3

```yaml
- name: Lazy Action Octopus
  uses: variant-inc/actions-octopus@v3
  with:
    default_branch: ${{ env.MASTER_BRANCH }}
    version: ${{ steps.lazy-setup.outputs.image_version }}
    package_read_token: ${{ secrets.PKG_READ }}
    ecr_repository: ${{ env.ECR_REPOSITORY }}
```

Refer
[octopus action](https://github.com/variant-inc/actions-octopus/blob/master/README.md)
for help setting up Variant Github Actions.

## Define Variant Apps YAML file

The Variant Apps YAML file defines your entire deployment.
This includes Variant helm charts and infrastructure.
Create your file with relative path of `.variant/deploy/api.yaml`.

Minimum required variables to create an Octopus project and an internal api.

```yaml
name: demo-python-flask-variant-api
tags:
  owner: CloudOps
  team: CloudOps
  purpose: Example
octopus:
  space: Default
  group: demo
chart:
  service:
    targetPort: 5000
```
