# YAML Spec

| Property | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| name | string | true | N/A | Name of the Octopus project and deployment |
| octopus | [Octopus](#octopus) | true | N/A | Octopus related config |
| infrastructure | [Infrastructure](#infrastructure) | false | N/A | Object of infrastructure configs |
| one of: (cron, api, handler) | [Cron](#cron), [Api](#api), [Handler](#handler) | false | N/A | Value to be applied to selected deployment type |

## Octopus

| Property | Type | Required | Default |
| --- | --- | --- | --- |
| space | string | true | N/A |
| group | string | true | N/A |

## Cron/API

### Cron

See [variant-cron](https://github.com/variant-inc/lazy-helm-charts/tree/variant-cron-1.0.0/charts/variant-cron) for list of acceptable inputs.

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

See [variant-api](https://github.com/variant-inc/lazy-helm-charts/tree/variant-api-2.0.0/charts/variant-api) for list of acceptable inputs.

Example

```yaml
api:
  service:
    targetPort: 5000
  authentication:
    enabled: true
```

### Handler

See [variant-handler](https://github.com/variant-inc/lazy-helm-charts/tree/variant-handler-1.0.2/charts/variant-handler) for list of acceptable inputs.

Example

```yaml
handler:
  configVars:
    TEST: from-git
    BootstrapServers: "#{kafka_bootstrap_servers}"
    SaslUsername: "#{kafka_sasl_username}"
  secretVars:
    SaslPassword: "#{kafka_sasl_password}"
```

## Infrastructure

| Property | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| buckets | [Buckets](#buckets) | false | N/A | S3 Buckets to optionally create and reference in your deployment
| topics | [Topics](#topics) | false | N/A | Create SNS Topics with optional configuration. |
| topic_subscriptions | [Topic Subscriptions](#topic-subscriptions) | false | N/A | Create SQS Queues and subscribe to an SNS Topics with options |
| database | [Database](#database) | false | N/A | Create Database within RDS with optional configuration. |

### Buckets

Supported attributes

```yaml
infrastructure:
  buckets:
    managed:
      - prefix: <BUCKET_NAME>
    existing:
      - project_name: <RELEASE_NAME_IN_NAMESPACE>
        project_group: <NAMESPACE>
        bucket_prefix: <BUCKET_NAME>
```

Exposed Environment Variables

- Name: Reference as `BUCKET__<BUCKET_PREFIX>__name`, `BUCKET__<BUCKET_PREFIX>__arn`

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

### Database

Supported attributes

```yaml
infrastructure:
  database:
    create_database: true
    db_name: sample-db
    extensions: ["postgis"]
    name: sample-role
```

Exposed Environment Variables

- Name: Reference as `DATABASE__name`, `DATABASE__user`, `DATABASE__host`, `DATABASE__password`
