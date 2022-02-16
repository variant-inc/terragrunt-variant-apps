# Variant Apps Terragrunt Module

Contents
- [Setup github action workflow](#setup-github-workflow)
- [Define Variant Apps YAML file](#define-variant-apps-yaml-file)
- [YAML Spec](./YAML.md) 

<br>

## Setup github workflow
Variant Apps Terragrunt Module is available for use with actions-octopus =< v3(-beta)

```yaml
- name: Lazy Action Octopus
  uses: variant-inc/actions-octopus@v3-beta
  with:
    default_branch: ${{ env.MASTER_BRANCH }}
    version: ${{ steps.lazy-setup.outputs.image_version }}
    package_read_token: ${{ secrets.PKG_READ }}
    ecr_repository: ${{ env.ECR_REPOSITORY }}
```

Refer [octopus action](https://github.com/variant-inc/actions-octopus/blob/master/README.md) for help settting up Varaint Github Actions.

<br>

## Define Variant Apps YAML file

The Variant Apps YAML file defines your entire deployment. This includes Variant helm charts and infrastructure. Create your file with relative path of `.variant/deploy/api.yaml`. 

Minimum required variables to create an Octopus project and an internal api. See [Variant Deploy YAML Spec](./YAML.md) for full attribute reference.

```yaml
name: demo-python-flask-variant-api
octopus:
  space: Default
  group: demo
chart:
  service:
    targetPort: 5000
```
