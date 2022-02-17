# Terragrunt Variant Apps

## Testing

1. Determine the environment variables required by terragrunt-variant-apps
   * Find the Variable Set "Terraform State Backup" for the devops-playground account
        - Set the environment variable `TERRAGRUNT_S3_BUCKET` to be the value of `S3_BUCKET`
        - Set the environment variable `TERRAGRUNT_DYNAMO_TABLE` to be the value of `DYNAMO_DB_TABLE`
   * Set the environment variable `VARIANT_DEPLOY_YAML_LOCATION` to the location of the Variant YAML file 
        -  Set `VARIANT_DEPLOY_YAML_LOCATION` to the full path of the YAML file

2. Create a YAML following the [YAML Spec](./spec) at the location previously specified.

3. Create terraform.tfvars.json file with the below json and fill in applicable live and dummy values to use in conjuction with make commands.The .tfvars.json file should be placed in the directory that you'd like to run demo-app.
    ```json
    {
      "cluster_name": "live",
      "namespace": "live",
      "domain": "live",
      "name": "live",
      "aws_resource_name_prefix": "live",
      "revision": "dummy",
      "user_tags": {
          "team": "dummy",
          "owner": "dummy",
          "purpose": "dummy"
      },
      "octopus_tags": {
          "release_channel": "dummy",
          "environment": "dummy",
          "project_group": "dummy",
          "space": "dummy",
          "project": "dummy"
      }
    }
    ```

## Validating

Validation can be done through applying your changes to demo-python-flask-variant-api for API chart changes or infrastructure changes. This can be done by setting the `deploy-package-version` in `demo-python-flask-variant-api/.github/workflows/build-octo-push.yaml` to your branch's latest Octopus package version. Adding paramters to `demo-python-flask-variant-api/.variant/deploy/api.yaml` may also be necessary.
