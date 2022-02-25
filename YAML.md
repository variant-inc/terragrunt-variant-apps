# YAML Spec

| Property | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| name | string | true | N/A | Name of the Octopus project and deployment |
| octopus | [Octopus](#octopus) | true | N/A | Octopus related config |
| infrastructure | [Infrastructure](#infrastructure) | false | N/A | Object of infratructure configs |
| one of: (cron, api) | [Cron](#cron), [Api](#api) | false | N/A | Value to be applied to selected deployment type |
| confignvVars | [map](#configvars) | false | N/A | User defined environment variables to be added to environment config map of your deployment |
| authentication | bool | false | false | Create authentication for deployment in the Helm Chart. Valid for only API |
 <br>

## Octopus

| Property | Type | Required | Default |
| --- | --- | --- | --- |
| space | string | true | N/A |
| group | string | true | N/A | 
 <br>

## Cron/API

### Cron

See [variant-cron](https://github.com/variant-inc/lazy-helm-charts/tree/variant-cron-1.0.0/charts/variant-cron) for list of acceptable inputs. Usage of cronJob.configVars is reserved. Define user defined environment variables using [yaml.envVars](#envvars).

Example
```yaml
cron:
  cronjob:
    schedule: "* * * * *"
    command:
      - "/bin/sh"
      - "-c"
      - "echo do something"
  nodeSelector:
    purpose: prime-test
    env: dpl
  node:
    create: true
    node_type: m3_medium
```

### API

See [variant-api](https://github.com/variant-inc/lazy-helm-charts/tree/variant-api-2.0.0/charts/variant-api) for list of acceptable inputs. Usage of api.configVars is reserved. Define user defined environment variables using [yaml.envVars](#envvars).

Example
```yaml
api:
  service:
    targetPort: 5000
```
<br>

## Authentication

### API

When selecting `authentication: true` when defining an api resource, Istio RBAC resources are created to require a valid JWT token before forwarding a request to your API.

<br>

## Config Variables

Define environment variables to be passed into Helm Release as a ConfigMap.

Example
```yaml
configVars:
  AWS_ENVIRONMENT: us-east-1
  HERE_API_KEY: #{HERE_API_KEY}
```

<br>

## Infrastructure

| Property | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| buckets | [Buckets](#buckets) | false | N/A | S3 Buckets to optionally create and reference in your deployment
| topics | [Topics](#topics) | false | N/A | Create SNS Topics with optional configuration. |
| topic_subscriptions | [Topic Subscriptions](#topic-subscriptions) | false | N/A | Create SQS Queues and subscribe to an SNS Topics with options |
<br>

### Buckets

Supported attributes

```yaml
infrastructure:
  buckets:
    managed:
        <BUCKET_KEY>:
            name: <BUCKET_NAME>
    existing:
        <BUCKET_KEY>:
            name: <BUCKET_NAME>
```

Exposed Environment Variables
- Name: Reference as `BUCKET__<BUCKET_KEY>__name`

<br>

### Topics

Supported attributes. See [aws_sns_topic](https://registry.terraform.io/modules/terraform-aws-modules/sns/aws/latest?tab=inputs) for valid attribute values. Only the attributes listed here are supported

```yaml
infrastructure:
  topics:
    <TOPIC_NAME>: # Add .fifo suffix for FIFO Topics
      # Optional parameters
      display_name: null
      fifo_topic: false
      content_based_deduplication: false
      delivery_policy: null
      sqs_success_feedback_role_arn: null
      sqs_success_feedback_sample_rate: 0
      sqs_failure_feedback_role_arn: null
```


Exposed Environment Variables
- ARN: Reference as `TOPIC__<TOPIC_NAME>__arn`

<br>

### Topic Subscriptions

Supported attributes. See [aws/sqs](https://registry.terraform.io/modules/terraform-aws-modules/sqs/aws/latest?tab=inputs) for valid attribute values. Only the attributes listed here are supported

```yaml
infrastructure:
  topic_subscriptions:
    <QUEUE_NAME>: # Add .fifo suffix for FIFO QUEUE
      topic_name: devops-<TOPIC_NAME> # As exists in AWS (including team prefix)
      # Optional Parameters and defaults
      raw_message_delivery: false
      fifo_queue: false
      visibility_timeout_seconds: 30
      message_retention_seconds: 345600
      max_message_size: 262144
      delay_seconds: 0
      receive_wait_time_seconds: 0
      policy: ""
      redrive_policy: ""
      content_based_deduplication: false
      kms_data_key_reuse_period_seconds: 0
```

Exposed Environment Variables
- URL: Reference as `QUEUE__<QUEUE_NAME>__url`
