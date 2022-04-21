# DX Workflow Docs

<!-- markdownlint-disable -->
- [DX Workflow Docs](#dx-workflow-docs)
  - [What is DX Workflow?](#what-is-dx-workflow)
  - [How to use DX workflow?](#how-to-use-dx-workflow)
    - [Supported Deployment Modules](#supported-deployment-modules)
  - [Application Type](#application-type)
  - [Infrastructure Type](#infrastructure-type)
  - [Misc. Features](#misc-features)
    - [DX Requirements](#dx-requirements)
      - [GitHub's Workflows Requirements](#githubs-workflows-requirements)
        - [Examples](#examples)
          - [.Net](#net)
          - [NodeJS](#nodejs)
          - [Python](#python)
          - [C++](#c)
      - [Deployment Requirements](#deployment-requirements)
        - [Example Below](#example-below)
      - [Application Requirements](#application-requirements)
  - [Full End-End Example Repositories](#full-end-end-example-repositories)
  - [Demos](#demos)

## What is DX Workflow?

The DX (Developer Experience) workflow is an application that reduces the time and effort to deploy an application(API, cron, queue handler, UI etc.) + supporting infrastructure. All the developers have to provide is a simple plain text YAML file.

## How to use DX workflow?

The DX workflow has certain requirements namely

1. CI build should be run using GitHub actions.
2. GitHub's workflows should be run in self-hosted runners.
3. Deployment is done with the help of octopus.

### Supported Deployment Modules

- [Application Type](#DXWorkflowDocumentation-ApplicationType)
- [Infrastructure Type](#DXWorkflowDocumentation-InfrastructureType)
- [Misc. Features](#DXWorkflowDocumentation-Misc.Features)

## Application Type

| **Type** | **Description**                                                                                    | **Docs**                                                                                                                 | **Availability**                          |
| -------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------- |
| API      | Console (no frontend) application which exposes a listener (endpoint/rest API)                     | [DX - API Deployment](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2411823113/DX+-+API+Deployment)         | AVAILABLE                                 |
| CRON     | Console (no frontend) application which runs on a schedule                                         | [DX - Cron Deployment](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2411790341/DX+-+Cron+Deployment)       | AVAILABLE                                 |
| HANDLER  | Console (no frontend) application which runs as standalone (always) and does not expose a listener | [DX - Handler Deployment](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2410840154/DX+-+Handler+Deployment) | AVAILABLE                                 |
| UI       | Frontend Application                                                                               |                                                                                                                          | IN PROGRESS <br>**Estimate**: 28 Apr 2022 |

## Infrastructure Type

| **Type**             | **Description**                             | **Docs**                                                                                                                                                                                                                                                                                                                                                                                          | **Availability** |
| -------------------- | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| S3                   | Object Storage like Google Drive, One Drive | [DX - S3](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2425225220/DX+-+S3) <br>[https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)                                                                                                                                                             | AVAILABLE        |
| Database - Postgres  | RDBMS (Sql Database)                        | [DX - Database - Postgres](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2425290755/DX+-+Database+-+Postgres) <br>[https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html)                                                                                                         | AVAILABLE        |
| SNS/SQS              | Queue                                       | [DX - SNS/SQS](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2424897538) <br>[https://docs.aws.amazon.com/sns/latest/dg/welcome.html](https://docs.aws.amazon.com/sns/latest/dg/welcome.html) <br>[https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html) | AVAILABLE        |
| Custom EC2 Instances | Supported for Cron                          | [DX - Custom Nodes](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2409660447/DX+-+Custom+Nodes)                                                                                                                                                                                                                                                                                      | AVAILABLE        |
| Dynamodb             |                                             |                                                                                                                                                                                                                                                                                                                                                                                                   | IN ROADMAP       |
| ElastiCache - Redis  |                                             |                                                                                                                                                                                                                                                                                                                                                                                                   | IN ROADMAP       |
| Kafka Topic          |                                             |                                                                                                                                                                                                                                                                                                                                                                                                   | IN ROADMAP       |

## Misc. Features

| **Type**                                     | **Description**                                                                                | **Docs** | **Availability** |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------- | -------- | ---------------- |
| Auto add YAML variables as Octopus Variables |                                                                                                |          | IN ROADMAP       |
| Custom Policies                              | Ability to add custom IAM Permissions required for the application to access some AWS services |          | IN ROADMAP       |
| Custom Terraform                             | Ability to add custom terraform                                                                |          | IN DISCUSSION    |

### DX Requirements

#### GitHub's Workflows Requirements

The DX workflow only supports CD (continuous deployment). In order to use this, you must have a working CI (continuous integration) GitHub Workflow using a CloudOps CI action.

Examples are below: [https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#Examples](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#Examples)

1. Relative to the root of your git repository, create a workflow file `.github/workflows/build-octo-push.yaml`
2. Add the checkout step, which will clone your code into the GitHub workspace

   ```yaml
   - name: Checkout
     uses: actions/checkout@v2
     with:
       fetch-depth: 0
   - name: Setup
     uses: variant-inc/actions-setup@v1
   ```

3. Use a CloudOps GitHub CI workflow that publishes an image

| **Action** | **Docs**                                                                                       | **Example**                                                                                                                                                                                                        |
| ---------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| .Net       | [https://github.com/variant-inc/actions-dotnet](https://github.com/variant-inc/actions-dotnet) | [https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#.Net](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#.Net)       |
| NodeJS     | [https://github.com/variant-inc/actions-nodejs](https://github.com/variant-inc/actions-nodejs) | [https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#NodeJS](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#NodeJS)   |
| Python     | [https://github.com/variant-inc/actions-python](https://github.com/variant-inc/actions-python) | [https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#Python](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#Python)   |
| C++        | [https://github.com/variant-inc/actions-cpp](https://github.com/variant-inc/actions-cpp)       | [https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#C%2B%2B](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2407563355/DX+Workflow+Documentation#C%2B%2B) |

1. Set up Actions Octopus in your workflow file. The version must be `v3`

   ```yaml
   - name: Action Octopus
     uses: variant-inc/actions-octopus@v3
   ```

   Refer [https://github.com/variant-inc/actions-octopus/blob/master/README.md](https://github.com/variant-inc/actions-octopus/blob/master/README.md) for help setting up Variant GitHub Actions.

![](https://drivevariant.atlassian.net/wiki/images/icons/grey_arrow_down.png)Examples

##### Examples

###### .Net

[pipeline.yml](https://github.com/variant-inc/demo-app/blob/main/.github/workflows/pipeline.yml)

```yaml
name: Build & Push to Octopus
on:
  push:

env:
  ECR_REPOSITORY: demo/dotnet-app

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
        uses: variant-inc/actions-dotnet@v1
        env:
          NUGET_TOKEN: ${{ secrets.PKG_READ }}
          AWS_DEFAULT_REGION: us-east-1
          AWS_REGION: us-east-1
          GITHUB_USER: variant-inc
        with:
          ecr_repository: ${{ env.ECR_REPOSITORY }}
          src_file_dir_path: "."
          nuget_push_enabled: "false"
          sonar_scan_in_docker: "false"
          nuget_push_token: ${{ secrets.GITHUB_TOKEN }}
          nuget_pull_token: ${{ secrets.PKG_READ }}

      - name: Lazy Action Octopus
        uses: variant-inc/actions-octopus@v3-beta
```

###### NodeJS

[pipeline.yml](https://github.com/variant-inc/demo-nodejs-app/blob/main/.github/workflows/pipeline.yml)

```yaml
name: Build & Push to Octopus
on:
  push:

env:
  ECR_REPO: "demo-nodejs-app"

jobs:
  octo:
    name: Push Container to Octopus
    runs-on: [eks]

    steps:
      - name: Checkout Code
        uses: actions/checkout@v2
        with:
          fetch-depth: 0

      - name: Setup
        uses: variant-inc/actions-setup@v1
        id: lazy-setup

      - name: Lazy action steps
        id: lazy-action
        uses: variant-inc/actions-nodejs@v1
        env:
          AWS_DEFAULT_REGION: us-east-1
          AWS_REGION: us-east-1
        with:
          ecr_repository: ${{ env.ECR_REPO }}
          container_push_enabled: "true"
          npm_test_script_name: "test"

      - name: Lazy Action Octopus
        uses: variant-inc/actions-octopus@v3
```

###### Python

[build-octo-push.yaml](https://github.com/variant-inc/demo-python-flask-variant-api/blob/master/.github/workflows/build-octo-push.yaml)

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
```

###### C++

[pipeline.yml](https://github.com/variant-inc/prime/blob/master/.github/workflows/pipeline.yml) 36

```yaml
name: CI/CD Pipeline

on:
  push:

jobs:
  build_test_scan:
    runs-on: eks
    name: CI Pipeline
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0

      - name: Actions Setup
        uses: variant-inc/actions-setup@v1
        id: actions-setup

      - name: Actions C++
        id: actions-cpp
        uses: variant-inc/actions-cpp@v1
        env:
          AWS_DEFAULT_REGION: us-east-1
          AWS_REGION: us-east-1
          GITHUB_USER: variant-devops
          GITHUB_TOKEN: ${{ secrets.PKG_READ }}
        with:
          container_push_enabled: true
          dockerfile_dir_path: "."
          gcc_version: 9
          ecr_repository: prime/app
          github_token: ${{ secrets.GITHUB_TOKEN }}
          conan_url: "https://drivevariant.jfrog.io/artifactory/api/conan/cybertron-conan"

      - name: Lazy Action Octopus
        uses: variant-inc/actions-octopus@v3
```

#### Deployment Requirements

The Variant Apps YAML file defines your entire deployment. This includes application and infrastructure needs for the project.

To get started, create a file with the relative path of `.variant/deploy/*.yaml` from the root of the project.

There can be any number of deployment YAML files, and each YAML file corresponds to an application + octopus project.

##### Example Below

```dir
Project
└─── .github
│     └─── workflows
│          └─── build-octo-push.yaml
│
└─── .variant
│     └─── deploy
│          └─── api.yaml
│          └─── cron1.yaml
│          └─── cron2.yaml
│
└─── src
│     └─── ...
│
└─── tests
│     └─── ...
└─── .dockerignore
└─── .gitattributes
└─── .gitignore
└─── Dockerfile
└─── README.md
└─── sonar-project.properties
```

More Examples can be found for an application type can be found at the following links

API Examples: [https://github.com/variant-inc/terragrunt-variant-apps/tree/master/examples/api](https://github.com/variant-inc/terragrunt-variant-apps/tree/master/examples/api)
CRON Examples: [https://github.com/variant-inc/terragrunt-variant-apps/tree/master/examples/cron](https://github.com/variant-inc/terragrunt-variant-apps/tree/master/examples/cron)
Handler Examples: [https://github.com/variant-inc/terragrunt-variant-apps/tree/master/examples/handler](https://github.com/variant-inc/terragrunt-variant-apps/tree/master/examples/handler)

For full attribute reference, please check the confluence pages below:

- [DX - API Deployment](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2411823113/DX+-+API+Deployment)
- [DX - Cron Deployment](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2411790341/DX+-+Cron+Deployment)
- [DX - Handler Deployment](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2410840154/DX+-+Handler+Deployment)
- [DX - Custom Nodes](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2409660447/DX+-+Custom+Nodes)
- [DX - Deploy Infrastructure resources](https://drivevariant.atlassian.net/wiki/spaces/CLOUD/pages/2423914497/DX+-+Deploy+Infrastructure+resources)

#### Application Requirements

1. Container should be run with a user with numerical ID.

   1. Example: `USER 10001`

2. Container should be run as non-root.
3. Host a health check endpoint via `GET /health` which returns a status code < 400 when healthy or >= 400 when unhealthy
4. Host a Prometheus metrics endpoint via `GET /metrics`

   - This chart configures a ServiceMonitor (see [Object Reference](https://github.com/variant-inc/lazy-helm-charts/tree/master/charts/variant-api#object-reference)) to collect metrics from your API
   - Middleware exists for most major API frameworks that provide useful out-of-the-box HTTP server metrics, and simple tools to push custom metrics for your product:

     - .Net - [.NET](https://github.com/prometheus-net/prometheus-net)
     - Node - [NestJS](https://github.com/digikare/nestjs-prom), [Express](https://github.com/joao-fontenele/express-prometheus-middleware)
     - Python - [Flask](https://github.com/rycus86/prometheus_flask_exporter), [Django](https://github.com/korfuri/django-prometheus)
     - C++

## Full End-End Example Repositories

| **Application Type** | **GitHub Repo**                                                                                                        | **GitHub Workflow Link**                                                                                                                                                                                                     | **Deployment YAML Link**                                                                                                                                                                                 |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Python API           | [https://github.com/variant-inc/positional-value-api](https://github.com/variant-inc/positional-value-api)             | [https://github.com/variant-inc/positional-value-api/blob/master/.github/workflows/build-octo-push.yaml](https://github.com/variant-inc/positional-value-api/blob/master/.github/workflows/build-octo-push.yaml)             | [https://github.com/variant-inc/positional-value-api/blob/master/.variant/deploy/api.yaml](https://github.com/variant-inc/positional-value-api/blob/master/.variant/deploy/api.yaml)                     |
| CRON C++             | [https://github.com/variant-inc/prime](https://github.com/variant-inc/prime)                                           | [https://github.com/variant-inc/prime/blob/master/.github/workflows/pipeline.yml](https://github.com/variant-inc/prime/blob/master/.github/workflows/pipeline.yml)                                                           | [https://github.com/variant-inc/prime/blob/master/.variant/deploy/prime-cron.yaml](https://github.com/variant-inc/prime/blob/master/.variant/deploy/prime-cron.yaml)                                     |
| Handler .Net         | [https://github.com/variant-inc/xpress-technologies-broker](https://github.com/variant-inc/xpress-technologies-broker) | [https://github.com/variant-inc/xpress-technologies-broker/blob/master/.github/workflows/build-octo-push.yaml](https://github.com/variant-inc/xpress-technologies-broker/blob/master/.github/workflows/build-octo-push.yaml) | [https://github.com/variant-inc/xpress-technologies-broker/blob/master/.variant/deploy/handler.yaml](https://github.com/variant-inc/xpress-technologies-broker/blob/master/.variant/deploy/handler.yaml) |

## Demos

| **Summary**                                  |                                                                                                                                                                                                                                                      |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| DX Demo - How to deploy application using DX | [https://variant-platform-misc.s3.amazonaws.com/CloudOps+Meeting+Recordings/Meeting-20220324_191811-Meeting+Recording.mp4](https://variant-platform-misc.s3.amazonaws.com/CloudOps+Meeting+Recordings/Meeting-20220324_191811-Meeting+Recording.mp4) |
