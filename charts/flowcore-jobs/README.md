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

## Configuration

The following table lists the configurable parameters for the flowcore-jobs chart and their default values.

### Global

| Name | Description | Value |
| ---- | ----------- | ----- |
| environment | Environment name | `flowcore` |
| platform | Platform that these jobs are part of | `flowcore` |
| imageRepository | The image repository to use for all jobs in this chart | `305363105399.dkr.ecr.eu-west-1.amazonaws.com` |
| imagePullSecrets | List of image pull secrets to use for all jobs in this chart | `[]` |
| transport | Ingress settings for the transport domain | `{}` |
| commonAnnotations | Annotations to set for all resources in the chart | `{}` |

### CronJobs

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