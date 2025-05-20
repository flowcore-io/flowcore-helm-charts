# Flowcore Jobs Helm Chart

This Helm chart is designed to deploy multiple Kubernetes job types in a Flowcore environment.

## Introduction

The `flowcore-jobs` chart provides a template for deploying different types of job resources that are part of the Flowcore platform. Currently, it supports CronJobs with plans to support other job types in the future.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.1.0+

## Installing the Chart

```console
helm install my-flowcore-jobs flowcore/flowcore-jobs
```

## Parameters

### Global

| Name               | Description                                                  | Value                                          |
| ------------------ | ------------------------------------------------------------ | ---------------------------------------------- |
| `environment`      | Environment name                                             | `flowcore`                                     |
| `platform`         | Platform that these jobs are part of                         | `flowcore`                                     |
| `imageRepository`  | The image repository to use for all jobs in this chart       | `305363105399.dkr.ecr.eu-west-1.amazonaws.com` |
| `imagePullSecrets` | List of image pull secrets to use for all jobs in this chart | `[]`                                           |

### Domain Settings

| Name                | Description                                              | Value |
| ------------------- | -------------------------------------------------------- | ----- |
| `transport`         | Ingress settings for the transport domain                | `{}`  |
| `transport.<n>`     | Environment variables for the transport in object format |       |
| `commonAnnotations` | Annotations to set for all resources in the chart        | `{}`  |

### CronJobs

| Name                                                                 | Description                                                                                        | Value |
| -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | ----- |
| `cronjobs`                                                           | List of cronjobs to deploy                                                                         | `{}`  |
| `cronjobs.<cronjobName>`                                             | Configuration entry for a cronjob                                                                  |       |
| `cronjobs.<cronjobName>.enabled`                                     | Whether to deploy this cronjob [boolean]                                                           |       |
| `cronjobs.<cronjobName>.podAnnotations`                              | Annotations to set for the pod                                                                     |       |
| `cronjobs.<cronjobName>.component`                                   | What type of cronjob this is [cleanup, report, maintenance, ...]                                   |       |
| `cronjobs.<cronjobName>.restartPolicy`                               | The restart policy to use for this cronjob, defaults to OnFailure [Always, OnFailure, Never]       |       |
| `cronjobs.<cronjobName>.imagePullSecrets`                            | List of image pull secrets to use for this cronjob [array]                                         |       |
| `cronjobs.<cronjobName>.source`                                      | What type of source this cronjob uses [node, go, rust, ...]                                        |       |
| `cronjobs.<cronjobName>.schedule`                                    | The cron schedule expression for this cronjob                                                      |       |
| `cronjobs.<cronjobName>.concurrencyPolicy`                           | How to treat concurrent executions [Allow, Forbid, Replace]                                        |       |
| `cronjobs.<cronjobName>.failedJobsHistoryLimit`                      | The number of failed job runs to keep                                                              |       |
| `cronjobs.<cronjobName>.successfulJobsHistoryLimit`                  | The number of successful job runs to keep                                                          |       |
| `cronjobs.<cronjobName>.suspend`                                     | Whether to suspend the cronjob                                                                     |       |
| `cronjobs.<cronjobName>.timeZone`                                    | The timezone name for the given schedule, default is UTC                                           |       |
| `cronjobs.<cronjobName>.startingDeadlineSeconds`                     | Optional deadline in seconds for starting the job if it misses scheduled time                      |       |
| `cronjobs.<cronjobName>.job`                                         | Configuration for the job                                                                          |       |
| `cronjobs.<cronjobName>.job.image`                                   | The image name to use for this job, excluding the repository [string]                              |       |
| `cronjobs.<cronjobName>.job.tag`                                     | The image tag to use for this job [string]                                                         |       |
| `cronjobs.<cronjobName>.job.resources`                               | Resource configuration for this job                                                                |       |
| `cronjobs.<cronjobName>.job.serviceAccount`                          | The service account to use for this job [string]                                                   |       |
| `cronjobs.<cronjobName>.job.activeDeadlineSeconds`                   | Optional deadline in seconds the job may be active before the system tries to terminate it         |       |
| `cronjobs.<cronjobName>.job.backoffLimit`                            | Specifies the number of retries before marking this job failed                                     |       |
| `cronjobs.<cronjobName>.env`                                         | Environment variables to set for this cronjob                                                      |       |
| `cronjobs.<cronjobName>.env.<variable>`                              | Configuration for an environment variable                                                          |       |
| `cronjobs.<cronjobName>.env.<variable>.value`                        | The value to set for this environment variable, use valueFrom if you want to use a secret [string] |       |
| `cronjobs.<cronjobName>.useTransport`                                | Array or Object of transport services to use for this cronjob                                      |       |
| `cronjobs.<cronjobName>.useTransport.<n>`                            | The name of the transport service to use                                                           |       |
| `cronjobs.<cronjobName>.useTransport.<n>.overrides`                  | Overrides for the transport service                                                                |       |
| `cronjobs.<cronjobName>.useTransport.<n>.overrides.<variable>`       | Configuration for an environment variable                                                          |       |
| `cronjobs.<cronjobName>.useTransport.<n>.overrides.<variable>.value` | The value to set for this environment variable, use valueFrom if you want to use a secret [string] |       |
| `cronjobs.<cronjobName>.volumes`                                     | list of config volumes to deploy                                                                   |       |
| `cronjobs.<cronjobName>.volumes.<n>`                                 | Configuration for a volume                                                                         |       |
| `cronjobs.<cronjobName>.volumes.<n>.config`                          | Config Map to use for this volume                                                                  |       |
| `cronjobs.<cronjobName>.volumes.<n>.secret`                          | Secret to use for this volume                                                                      |       |
| `cronjobs.<cronjobName>.volumes.<n>.mountPath`                       | The mount path to use for this volume                                                              |       |
| `cronjobs.<cronjobName>.volumes.<n>.subPath`                         | The sub path to use for this volume, optional                                                      |       |
| `cronjobs.<cronjobName>.volumes.<n>.mainMount`                       | Whether this volume is mounted to the main container, optional [yes, no] defaults to yes           |       |
| `cronjobs.<cronjobName>.volumes.<n>.type`                            | The type of volume to use [configMap, secret, emptyDir]                                            |       |
| `cronjobs.<cronjobName>.affinity`                                    | Affinity configuration for this cronjob                                                            |       |
| `cronjobs.<cronjobName>.castAiSpot`                                  | Configure cronjob for spot instance prefer or required                                             |       |
| `cronjobs.<cronjobName>.castAiNodeTemplate`                          | Cast AI node template values [string array]                                                        |       |

The `cronjobs` section allows you to define multiple CronJobs to be deployed. Each CronJob can be configured independently.

Here's an example configuration for a CronJob:

```yaml
cronjobs:
  dataCleanup:
    enabled: true
    component: cleanup
    restartPolicy: OnFailure
    schedule: "0 0 * * *"  # Daily at midnight
    concurrencyPolicy: Forbid
    failedJobsHistoryLimit: 3
    successfulJobsHistoryLimit: 3
    job:
      image: "data-cleanup"
      tag: "latest"
      resources:
        limits:
          cpu: 500m
          memory: 512Mi
        requests:
          cpu: 100m
          memory: 128Mi
    env:
      RETENTION_DAYS:
        value: "30"
```

## CronJob Properties

Each CronJob can be configured with the following properties:

- `enabled`: Whether to deploy this CronJob (boolean)
- `podAnnotations`: Annotations to set for the pod
- `component`: What type of CronJob this is (cleanup, report, maintenance, etc.)
- `restartPolicy`: The restart policy to use for this CronJob (Always, OnFailure, Never)
- `imagePullSecrets`: List of image pull secrets to use for this CronJob
- `source`: What type of source this CronJob uses (node, go, rust, etc.)
- `schedule`: The cron schedule expression for this CronJob
- `concurrencyPolicy`: How to treat concurrent executions (Allow, Forbid, Replace)
- `failedJobsHistoryLimit`: The number of failed job runs to keep
- `successfulJobsHistoryLimit`: The number of successful job runs to keep
- `suspend`: Whether to suspend the CronJob
- `timeZone`: The timezone name for the given schedule
- `startingDeadlineSeconds`: Optional deadline in seconds for starting the job if it misses scheduled time
- `job`: Configuration for the job
  - `image`: The image name to use for this job
  - `tag`: The image tag to use for this job
  - `resources`: Resource configuration for this job
  - `serviceAccount`: The service account to use for this job
  - `activeDeadlineSeconds`: Optional deadline in seconds the job may be active before the system tries to terminate it
  - `backoffLimit`: Specifies the number of retries before marking this job failed
- `env`: Environment variables to set for this CronJob
- `useTransports`: Array or Object of transport services to use for this CronJob
- `volumes`: List of config volumes to deploy
- `affinity`: Affinity configuration for this CronJob
- `castAiSpot`: Configure CronJob for spot instance prefer or required
- `castAiNodeTemplate`: Cast AI node template values

## Example: Full values.yaml

```yaml
environment: flowcore
platform: flowcore
imageRepository: 305363105399.dkr.ecr.eu-west-1.amazonaws.com
imagePullSecrets: []

cronjobs:
  dataCleanup:
    enabled: true
    component: cleanup
    restartPolicy: OnFailure
    schedule: "0 0 * * *"
    concurrencyPolicy: Forbid
    job:
      image: "data-cleanup"
      tag: "1.0.0"
      resources:
        limits:
          cpu: 500m
          memory: 512Mi
        requests:
          cpu: 100m
          memory: 128Mi
      backoffLimit: 3
    env:
      RETENTION_DAYS:
        value: "30"
      LOG_LEVEL:
        value: "info"

  reportGenerator:
    enabled: true
    component: report
    restartPolicy: OnFailure
    schedule: "0 8 * * 1"  # Every Monday at 8 AM
    concurrencyPolicy: Forbid
    job:
      image: "report-generator"
      tag: "1.0.0"
      resources:
        limits:
          cpu: 1000m
          memory: 1Gi
        requests:
          cpu: 250m
          memory: 256Mi
    env:
      REPORT_TYPE:
        value: "weekly"
``` 