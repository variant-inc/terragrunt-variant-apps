# Secrets

- [Secrets](#secrets)
  - [Definition](#definition)
  - [Secret Variables](#secret-variables)
  - [Secret Variables Versus Config Variables](#secret-variables-versus-config-variables)
  - [Secrets Configuration](#secrets-configuration)
  - [References](#references)

## Definition

A Secret is an object that contains a small amount of sensitive data such as a
password, a token, or a key. Such information might otherwise be put in a Pod
specification or in a container image. Using a Secret means that you don't
need to include confidential data in your application code.

## Secret Variables

- Used for sensitive secret values (`secretVars`) such as API keys, passwords,
  and tokens.
- Configured as a map of key/value pairs. Ex: `userPassword: P@ssw0rd123`

## Secret Variables Versus Config Variables

- secretVars contain sensitive data, config variables `configVars` do not.
- configVars are non-sensitive data that can be defined for the application.
- configVars are also configured as key/value pairs. Ex: `temp_directory: /tmp`
- configVars are only used when the data is **not** sensitive.

## Secrets Configuration
<!-- markdownlint-disable MD013 -->
| Input | [Kubernetes Object Type](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/) | Description | Default Value |
| - | - | - | - |
| secrets | ExternalSecret | A list of secrets to configure to make available to your API, UI, or Handler. Create your secret in [AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html) as plain text. Full contents of this secret will be mounted as a file your application can read. | [] |
| secrets[N].name | ExternalSecret | Name of the AWS Secrets Manager secret |
| secrets[N].fileName | ExternalSecret, Deployment | Desired file name which will contain all contents of the AWS secret |
| secrets[N].mountPath | Deployment | Directory (no trailing slash) where the above secrets[N].fileName will be mounted (e.g. if fileName = secret.json and mountPath = /app/secrets then secret will be available at /app/secrets/secret.json) | |
<!-- markdownlint-enable -->
## References
  <!-- markdownlint-disable-next-line MD013 -->
- [Kubernetes Secret Configuration Reference](https://kubernetes.io/docs/concepts/configuration/secret/)
