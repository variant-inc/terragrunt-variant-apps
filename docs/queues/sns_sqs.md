# Queues - SNS/SQS

- [Queues - SNS/SQS](#queues---snssqs)
  - [SNS](#sns)
    - [Examples - SNS](#examples---sns)
  - [Supported Attributes - SNS](#supported-attributes---sns)
    - [Exposed Environment Variables - SNS](#exposed-environment-variables---sns)
  - [SQS](#sqs)
    - [Examples - SQS](#examples---sqs)
  - [Supported Attributes - SQS](#supported-attributes---sqs)
    - [Exposed Environment Variables - SQS](#exposed-environment-variables---sqs)

## SNS

Create SNS Topics with optional configuration.

*If no sns is needed, do not add `sns` under `infrastructure`*

Adding topic with below format will create an env variable and can be referenced as SNS__<TOPIC_NAME>__arn in the code

### Examples - SNS

Here is the example sample to add topics to application

```bash
infrastructure:
  sns_topics:
    - name: datascience-test-topic
      display_name: this-is-test
```

The application will be deployed with the following `environnement variables`

```bash
SNS__this-is-test__arn = "arn:aws:sns:us-west-2:108141096600:dynamodb"
```

## Supported Attributes - SNS

The following attributes should be added under

```bash
infrastructure:
  sns:
```

[Inputs](../modules/common/sns/README.md#inputs)

### Exposed Environment Variables - SNS

Below are the exposed env variables and can be referenced  in the code with below names.

| Env variable           | Description                     |
| ---------------------- | ------------------------------- |
| SNS__<TOPIC_NAME>__arn | Env variable to refer topic arn |

## SQS

Create SQS Queues and subscribe to an SNS Topics with options.

*If no sns is needed, do not add `sns_sqs_subscriptions` under `infrastructure`*

Adding topic with below format will create an env variable and can be referenced as SQS__<QUEUE_NAME>__url in the code.

### Examples - SQS

Here is the sample format to add topics to the application.

```bash
infrastructure:
  sns_sqs_subscriptions:
    - name: <SQS_NAME> # Add .fifo suffix for FIFO QUEUE
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

## Supported Attributes - SQS

The following attributes should be added under

```bash
infrastructure:
  sns_sqs_subscriptions:
```

[Inputs](../modules/common/sqs/README.md#inputs)

### Exposed Environment Variables - SQS

Below are the exposed env variables and can be referenced  in the code with below names.

| Env variable             | Description                     |
| ------------------------ | ------------------------------- |
| QUEUE__<QUEUE_NAME>__url | Env variable to refer queue url |
