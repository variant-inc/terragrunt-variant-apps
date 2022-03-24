# Queues - SNS/SQS

- [Queues - SNS/SQS](#queues---snssqs)
  - [SNS](#sns)
    - [topics](#topics)
    - [Supported attributes under topics](#supported-attributes-under-topics)
    - [Exposed environment variables](#exposed-environment-variables)
  - [SQS](#sqs)
    - [topic_subscriptions](#topic_subscriptions)
    - [Exposed environment variables](#exposed-environment-variables-1)

## SNS

Create SNS Topics with optional configuration. This need to be added under infrastructure section with attribute topics and support attributes. Skipping this section will not add topics to the application configuration.

Adding topic with below format will create an env variable and can be referenced as TOPIC__<TOPIC_NAME>__arn in the code

### topics

Here is the example sample to add topics to application

```bash
infrastructure:
  topics:
    - name: datascience-test-topic
      display_name: this-is-test
```

Here is the sample format to add topics to the application.

```bash
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

| Property   | Type   | Required | Default | Description                                                                               |
|------------|--------|----------|---------|-------------------------------------------------------------------------------------------|
| TOPIC_NAME | string | true     | N/A     | This need to be added to create new sns topic. Add as an array to create multiple topics. |

### Supported attributes under topics

See [aws_sns_topic](https://registry.terraform.io/modules/terraform-aws-modules/sns/aws/latest?tab=inputs) or [terraform-aws-sns](https://github.com/variant-inc/terraform-aws-sns/blob/master/README.md)  for valid attribute values. Only the attributes listed here are supported.

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|  aws_resource_name_prefix | Prefix of team name to be applied to created resources. | `string` | n/a | yes |
|  content_based_deduplication | Boolean indicating whether or not to enable content-based deduplication for FIFO topics. | `bool` | `false` | no |
|  delivery_policy | The SNS delivery policy | `string` | `null` | no |
|  display_name | The display name for the SNS topic | `string` | `null` | no |
|  fifo_topic | Boolean indicating whether or not to create a FIFO (first-in-first-out) topic | `bool` | `false` | no |
|  kms_key_sns_alias_arn | The ID(ARN) of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK | `string` | `null` | no |
|  name | The name of the SNS topic to create | `string` | n/a | yes |
|  sqs_failure_feedback_role_arn | IAM role for failure feedback | `string` | `null` | no |
|  sqs_success_feedback_role_arn | The IAM role permitted to receive success feedback for this topic | `string` | `null` | no |
|  sqs_success_feedback_sample_rate | Percentage of success to sample | `string` | `null` | no |
| tags | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |

### Exposed environment variables

Below are the exposed env variables and can be referenced  in the code with below names.

| Env variable             | Description                     |
|--------------------------|---------------------------------|
| TOPIC__<TOPIC_NAME>__arn | Env variable to refer topic arn |

## SQS

Create SQS Queues and subscribe to an SNS Topics with options. This need to be added under infrastructure section with attribute topic_subscriptions and support attributes. Skipping this section will not add topic subscription to queues. It is suggested to create only one queue per application.

Adding topic with below format will create an env variable and can be referenced as QUEUE__<QUEUE_NAME>__url in the code.

### topic_subscriptions

Here is the example sample to add topic subscriptions to the application.

```bash
infrastructure:
  topic_subscriptions:
    - name: datascience-test-queue-sub
      topic_name: datascience-test-topic
```

Here is the sample format to add  topic subscriptions to the application.

```bash
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

| Property   | Type   | Required | Default | Description                                    |
|------------|--------|----------|---------|------------------------------------------------|
| QUEUE_NAME | string | true     | N/A     | This need to be added to create new sqs queue. |

See [aws/sqs](https://registry.terraform.io/modules/terraform-aws-modules/sqs/aws/latest?tab=inputs) or [terraform-aws-sns-subscription-sqs](https://github.com/variant-inc/terraform-aws-sns-subscription-sqs/blob/master/README.md)  for valid attribute values. Only the attributes listed here are supported

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|  aws_resource_name_prefix | Prefix of team name to be applied to created resources. | `string` | n/a | no |
|  content_based_deduplication | Enables content-based deduplication for FIFO queues | `bool` | `null` | no |
|  delay_seconds | The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes) | `number` | `null` | no |
|  fifo_queue | Boolean designating a FIFO queue | `bool` | `null` | no |
|  kms_data_key_reuse_period_seconds | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours) | `number` | `null` | no |
|  kms_key_sns_alias_arn | The ID(ARN) of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK | `string` | `null` | no |
| max_message_size | The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB) | `number` | `null` | no |
|  message_retention_seconds | The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days) | `number` | `null` | no |
| name| This is the human-readable name of the queue. If omitted, Terraform will assign a random name. | `string` | `null` | no |
| policy | The JSON policy for the SQS queue | `string` | `null` | no |
|  raw_message_delivery | Whether to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property) | `bool` | `false` | no |
|  receive_wait_time_seconds | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds) | `number` | `null` | no |
|  redrive_policy | The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ("5") | `string` | `null` | no |
|  tags | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
|  topic_name | Topic to subscribe | `string` | `null` | no |
|  visibility_timeout_seconds | The visibility timeout for the queue. An integer from 0 to 43200 (12 hours) | `number` | `null` | no |

### Exposed environment variables

Below are the exposed env variables and can be referenced  in the code with below names.

| Env variable             | Description                     |
|--------------------------|---------------------------------|
| QUEUE__<QUEUE_NAME>__url | Env variable to refer queue url |