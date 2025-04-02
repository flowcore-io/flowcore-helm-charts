# Flowcore Platform

An Helm chart for installing a dedicated instance of the Flowcore Platform

## Prerequisites

- Kubernetes 1.22+
- Helm 3.8+
- Ingress Controller
- Cert Manager

## Installing the Chart

To add the chart repository to Helm:

```bash
helm repo add flowcore https://flowcore-io.github.io/flowcore-helm-charts/
```

create a `values.yaml` file and fill in the deployments section. then run:

```bash
helm install my-release flowcore/flowcore-platform -f values.yaml
```

## Parameters

### Flowcore Platform Configuration

| Name                                  | Description                                                                                 | Value         |
| ------------------------------------- | ------------------------------------------------------------------------------------------- | ------------- |
| `flowcore.tenant`                     | The tenant name (e.g. "my-org")                                                             | `""`          |
| `flowcore.controlPlaneEnv`            | The control plane environment (e.g. "azure-eu")                                             | `""`          |
| `flowcore.configurationRepository`    | The configuration repository (e.g. "https://github.com/example-org/flowcore-configuration") | `""`          |
| `flowcore.keyspace`                   | The keyspace configuration                                                                  | `{}`          |
| `flowcore.keyspace.replicationFactor` | The number of replicas                                                                      | `3`           |
| `flowcore.domain`                     | The domain                                                                                  | `example.com` |
| `flowcore.tlsSecret`                  | The TLS secret                                                                              | `example-tls` |

### ArgoCD Configuration

| Name               | Description   | Value     |
| ------------------ | ------------- | --------- |
| `argocd.namespace` | The namespace | `argocd`  |
| `argocd.project`   | The project   | `default` |

### Cassandra Configuration

| Name                                  | Description                                                                | Value                            |
| ------------------------------------- | -------------------------------------------------------------------------- | -------------------------------- |
| `cassandra.enabled`                   | Whether to install the Cassandra instance                                  | `true`                           |
| `cassandra.dbUser`                    | The Cassandra user configuration                                           | `{}`                             |
| `cassandra.dbUser.existingSecret`     | The name of the existing secret containing the Cassandra user and password | `platform-source-cassandra-user` |
| `cassandra.cluster`                   | The Cassandra cluster configuration                                        | `{}`                             |
| `cassandra.cluster.name`              | The name of the Cassandra cluster                                          | `platform-source`                |
| `cassandra.cluster.seedCount`         | The number of seed nodes                                                   | `2`                              |
| `cassandra.cluster.numTokens`         | The number of tokens                                                       | `16`                             |
| `cassandra.cluster.datacenter`        | The datacenter name                                                        | `datacenter1`                    |
| `cassandra.replicaCount`              | The number of replicas                                                     | `3`                              |
| `cassandra.resources`                 | The resources for the Cassandra instance                                   | `{}`                             |
| `cassandra.resources.requests.cpu`    | The CPU request                                                            | `8`                              |
| `cassandra.resources.requests.memory` | The memory request                                                         | `16Gi`                           |
| `cassandra.resources.limits.cpu`      | The CPU limit                                                              | `8`                              |
| `cassandra.resources.limits.memory`   | The memory limit                                                           | `16Gi`                           |
| `cassandra.persistence`               | The persistence configuration                                              | `{}`                             |
| `cassandra.persistence.storageClass`  | The storage class for the persistent volume                                |                                  |
| `cassandra.persistence.size`          | The size of the persistent volume                                          | `512Gi`                          |
| `cassandra.metrics`                   | The metrics configuration                                                  | `{}`                             |
| `cassandra.metrics.enabled`           | Whether to enable the metrics                                              | `true`                           |
| `cassandra.jvm.maxHeapSize`           | The maximum heap size (1/4 or 1/2 of the total memory)                     | `2048m`                          |
| `cassandra.jvm.newHeapSize`           | The new heap size (1/4 of the max heap size)                               | `1024m`                          |

### Valkey HA Configuration

| Name                                         | Description                                                  | Value                       |
| -------------------------------------------- | ------------------------------------------------------------ | --------------------------- |
| `valkey-ha.enabled`                          | Whether to install the Valkey HA instance                    | `true`                      |
| `valkey-ha.nameOverride`                     | The name override                                            | `valkey-ha`                 |
| `valkey-ha.fullnameOverride`                 | The full name override                                       | `valkey-ha`                 |
| `valkey-ha.architecture`                     | The architecture to use                                      | `replication`               |
| `valkey-ha.sentinel.enabled`                 | Whether to install the Sentinel instance                     | `true`                      |
| `valkey-ha.sentinel.primarySet`              | The primary set to use                                       | `fcmprimary`                |
| `valkey-ha.sentinel.resources`               | The resources for the Sentinel instance                      |                             |
| `valkey-ha.auth.enabled`                     | Whether to install the Auth instance                         | `true`                      |
| `valkey-ha.auth.sentinel`                    | Whether to use the Sentinel instance                         | `true`                      |
| `valkey-ha.auth.existingSecret`              | The name of the existing secret containing the Auth password | `platform-source-valkey-ha` |
| `valkey-ha.auth.existingSecretPasswordKey`   | The key in the existing secret containing the Auth password  | `password`                  |
| `valkey-ha.primary.enabled`                  | Whether to install the primary instance                      | `true`                      |
| `valkey-ha.primary.replicaCount`             | The number of replicas                                       | `1`                         |
| `valkey-ha.primary.resources`                | The resources for the primary instance                       |                             |
| `valkey-ha.primary.persistence.enabled`      | Whether to install the persistence                           | `true`                      |
| `valkey-ha.primary.persistence.size`         | The size of the persistent volume                            | `50Gi`                      |
| `valkey-ha.primary.persistence.storageClass` | The storage class for the persistent volume                  |                             |
| `valkey-ha.replica.enabled`                  | Whether to install the replica instance                      | `true`                      |
| `valkey-ha.replica.replicaCount`             | The number of replicas                                       | `3`                         |
| `valkey-ha.replica.resources`                | The resources for the replica instance                       |                             |
| `valkey-ha.replica.persistence.enabled`      | Whether to install the persistence                           | `true`                      |
| `valkey-ha.replica.persistence.size`         | The size of the persistent volume                            | `50Gi`                      |
| `valkey-ha.replica.persistence.storageClass` | The storage class for the persistent volume                  |                             |

### Valkey Single Configuration

| Name                                             | Description                                                  | Value                           |
| ------------------------------------------------ | ------------------------------------------------------------ | ------------------------------- |
| `valkey-single.enabled`                          | Whether to install the Valkey single instance                | `false`                         |
| `valkey-single.nameOverride`                     | The name override                                            | `valkey-single`                 |
| `valkey-single.fullnameOverride`                 | The full name override                                       | `valkey-single`                 |
| `valkey-single.architecture`                     | The architecture to use                                      | `single`                        |
| `valkey-single.auth.enabled`                     | Whether to install the Auth instance                         | `true`                          |
| `valkey-single.auth.existingSecret`              | The name of the existing secret containing the Auth password | `platform-source-valkey-single` |
| `valkey-single.auth.existingSecretPasswordKey`   | The key in the existing secret containing the Auth password  | `password`                      |
| `valkey-single.primary.enabled`                  | Whether to install the primary instance                      | `true`                          |
| `valkey-single.primary.replicaCount`             | The number of replicas                                       | `1`                             |
| `valkey-single.primary.resources`                | The resources for the primary instance                       |                                 |
| `valkey-single.primary.persistence.enabled`      | Whether to install the persistence                           | `true`                          |
| `valkey-single.primary.persistence.size`         | The size of the persistent volume                            | `50Gi`                          |
| `valkey-single.primary.persistence.storageClass` | The storage class for the persistent volume                  |                                 |

### Valkey Cache Configuration

| Name                                            | Description                                  | Value          |
| ----------------------------------------------- | -------------------------------------------- | -------------- |
| `valkey-cache.enabled`                          | Whether to install the Valkey cache instance | `false`        |
| `valkey-cache.nameOverride`                     | The name override                            | `valkey-cache` |
| `valkey-cache.fullnameOverride`                 | The full name override                       | `valkey-cache` |
| `valkey-cache.architecture`                     | The architecture to use                      | `single`       |
| `valkey-cache.auth.enabled`                     | Whether to install the Auth instance         | `false`        |
| `valkey-cache.primary.enabled`                  | Whether to install the primary instance      | `true`         |
| `valkey-cache.primary.replicaCount`             | The number of replicas                       | `1`            |
| `valkey-cache.primary.resources`                | The resources for the primary instance       |                |
| `valkey-cache.primary.persistence.enabled`      | Whether to install the persistence           | `true`         |
| `valkey-cache.primary.persistence.size`         | The size of the persistent volume            | `5Gi`          |
| `valkey-cache.primary.persistence.storageClass` | The storage class for the persistent volume  |                |

### NATS Configuration

| Name                                               | Description                                                                                                  | Value  |
| -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ------ |
| `nats.nameOverride`                                | The name override                                                                                            | `nats` |
| `nats.fullnameOverride`                            | The full name override                                                                                       | `nats` |
| `nats.enabled`                                     | Whether to install the NATS instance                                                                         | `true` |
| `nats.config`                                      | The NATS configuration                                                                                       | `{}`   |
| `nats.config.cluster.enabled`                      | Whether to install the NATS cluster                                                                          | `true` |
| `nats.config.cluster.replicas`                     | The number of replicas                                                                                       | `3`    |
| `nats.config.jetstream.enabled`                    | Whether to install the NATS JetStream instance                                                               | `true` |
| `nats.config.jetstream.fileStore.pvc.size`         | The size of the persistent volume                                                                            | `10Gi` |
| `nats.config.jetstream.fileStore.pvc.size`         | The size of the persistent volume                                                                            | `10Gi` |
| `nats.config.jetstream.fileStore.pvc.storageClass` | The storage class for the persistent volume                                                                  |        |
| `nats.container.env.GOMEMLIMIT`                    | The memory limit, 90% of the memory limit, different from k8s units, suffix must be B, KiB, MiB, GiB, or TiB | `7GiB` |
| `nats.container.merge.resources.requests.cpu`      | The CPU request                                                                                              | `2`    |
| `nats.container.merge.resources.requests.memory`   | The memory request                                                                                           | `8Gi`  |
| `nats.container.merge.resources.limits.cpu`        | The CPU limit                                                                                                | `2`    |
| `nats.container.merge.resources.limits.memory`     | The memory limit                                                                                             | `8Gi`  |

### PostgreSQL Operator Configuration

| Name                                   | Description                                | Value                 |
| -------------------------------------- | ------------------------------------------ | --------------------- |
| `postgresql-operator.enabled`          | Whether to install the PostgreSQL operator | `true`                |
| `postgresql-operator.fullnameOverride` | The full name override                     | `postgresql-operator` |

### PostgreSQL Configuration

| Name                                  | Description                                                           | Value                                    |
| ------------------------------------- | --------------------------------------------------------------------- | ---------------------------------------- |
| `postgresql.enabled`                  | Whether to install the PostgreSQL instance                            | `true`                                   |
| `postgresql.existingSecret`           | The name of the existing secret containing the PostgreSQL credentials | `platform-source-postgresql-credentials` |
| `postgresql.replicas`                 | The number of replicas                                                | `3`                                      |
| `postgresql.persistence.size`         | The size of the persistent volume                                     | `200Gi`                                  |
| `postgresql.persistence.storageClass` | The storage class for the persistent volume                           |                                          |
| `postgresql.tolerations`              |                                                                       |                                          |
| `postgresql.resources`                |                                                                       |                                          |
| `env`                                 |                                                                       |                                          |
| `config`                              |                                                                       |                                          |
| `bootstrap`                           |                                                                       |                                          |
| `metadata`                            |                                                                       |                                          |
| `serverAltDNSNames`                   |                                                                       |                                          |

### ArangoDB Operator Configuration

| Name                        | Description                              | Value  |
| --------------------------- | ---------------------------------------- | ------ |
| `arangodb-operator.enabled` | Whether to install the ArangoDB operator | `true` |

### ArangoDB Configuration

| Name                      | Description                                                           | Value                                  |
| ------------------------- | --------------------------------------------------------------------- | -------------------------------------- |
| `arangodb.enabled`        | Whether to install the ArangoDB instance                              | `true`                                 |
| `arangodb.storage`        | The size of the persistent volume                                     | `30Gi`                                 |
| `arangodb.replicas`       | The number of replicas                                                | `3`                                    |
| `arangodb.existingSecret` | The name of the existing secret containing the ArangoDB root password | `platform-source-arangodb-credentials` |

### External Secrets Configuration

| Name                       | Description                                      | Value  |
| -------------------------- | ------------------------------------------------ | ------ |
| `external-secrets.enabled` | Whether to install the External Secrets instance | `true` |

### External Secrets Secret Stores Configuration

| Name                                           | Description                          | Value                      |
| ---------------------------------------------- | ------------------------------------ | -------------------------- |
| `secretStores.enabled`                         | Whether to install the secret stores | `true`                     |
| `secretStores.stores`                          | The secret stores                    | `{}`                       |
| `secretStores.stores.orgSecret`                | The org secret                       | `{}`                       |
| `secretStores.stores.orgSecret.enabled`        | Whether to install the org secret    | `true`                     |
| `secretStores.stores.orgSecret.type`           | The type of the secret               | `AWS`                      |
| `secretStores.stores.orgSecret.storeType`      | The store type                       | `SecretsManager`           |
| `secretStores.stores.orgSecret.region`         | The region                           | `eu-west-1`                |
| `secretStores.stores.orgSecret.authSecretName` | The name of the auth secret          | `flowcore-external-secret` |

### Ensure Credentials

| Name                                          | Description                                   | Value                                         |
| --------------------------------------------- | --------------------------------------------- | --------------------------------------------- |
| `ensureCredentials.enabled`                   | Whether to install the ensure credentials job | `true`                                        |
| `ensureCredentials.image`                     | The image                                     | `{}`                                          |
| `ensureCredentials.image.repository`          | The image repository                          | `flowcoreio/job-create-dedicated-credentials` |
| `ensureCredentials.image.tag`                 | The image tag                                 | `1.12.0`                                      |
| `ensureCredentials.env.TENANT_ID`             | The tenant ID                                 | `{}`                                          |
| `ensureCredentials.env.TENANT_NAME`           | The tenant name                               | `{}`                                          |
| `ensureCredentials.resources`                 | The resources for the ensure credentials job  | `{}`                                          |
| `ensureCredentials.resources.limits.cpu`      | The CPU limit                                 | `100m`                                        |
| `ensureCredentials.resources.limits.cpu`      | The CPU limit                                 | `100m`                                        |
| `ensureCredentials.resources.limits.memory`   | The memory limit                              | `128Mi`                                       |
| `ensureCredentials.resources.requests.cpu`    | The CPU request                               | `50m`                                         |
| `ensureCredentials.resources.requests.cpu`    | The CPU request                               | `50m`                                         |
| `ensureCredentials.resources.requests.memory` | The memory request                            | `64Mi`                                        |

### Flowcore Platform Common Configuration

| Name                                                                    | Description                                       | Value                                                                       |
| ----------------------------------------------------------------------- | ------------------------------------------------- | --------------------------------------------------------------------------- |
| `flowcore-microservices.enabled`                                        | Whether to install the Flowcore Platform Services | `true`                                                                      |
| `flowcore-microservices.imageRepository`                                | The image repository                              | `flowcore-io`                                                               |
| `flowcore-microservices.oidcWellKnownUrl`                               | The OIDC well-known URL                           | `https://auth.flowcore.io/realms/flowcore/.well-known/openid-configuration` |
| `flowcore-microservices.transport.nats.NATS_SERVERS.value`              | The NATS servers                                  | `nats://nats:4222`                                                          |
| `flowcore-microservices.commonAnnotations.argocd.argoproj.io/sync-wave` | The sync wave                                     | `"-3"`                                                                      |

### Flowcore Ingestion Channel

| Name                                                                                  | Description                                                  | Value                                                        |
| ------------------------------------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `flowcore-microservices.deployments.ingestionChannel.enabled`                         | Whether to install the Ingestion Channel instance            | `true`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.deployment.image`                | The image                                                    | `service-ingestion`                                          |
| `flowcore-microservices.deployments.ingestionChannel.deployment.tag`                  | The tag                                                      | `1.5.5`                                                      |
| `flowcore-microservices.deployments.ingestionChannel.deployment.replicas`             | The number of replicas                                       | `2`                                                          |
| `flowcore-microservices.deployments.ingestionChannel.metrics.enabled`                 | Whether to install the metrics                               | `true`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.metrics.port`                    | The port                                                     | `3001`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.useTransports`                   | The transports to use                                        | `nats`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.castAiSpot`                      | The castAiSpot                                               | `preferred`                                                  |
| `flowcore-microservices.deployments.ingestionChannel.env.REDIS_URL`                   | The Redis URL                                                | `{}`                                                         |
| `flowcore-microservices.deployments.ingestionChannel.env.METRICS_SERVICE_NAME`        | The metrics service name                                     | `ingestion_channel`                                          |
| `flowcore-microservices.deployments.ingestionChannel.env.DEFAULT_TTL_ON_STORED_EVENT` | The default TTL on stored event in seconds                   | `259200`                                                     |
| `flowcore-microservices.deployments.ingestionChannel.env.NATS_QUEUE`                  | The NATS queue                                               |                                                              |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_CONTACT_POINTS`    | The Cassandra contact points                                 | `flowcore-cassandra`                                         |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_USERNAME`          | The Cassandra username                                       | `cassandra-username in ingestion-channel-credentials secret` |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_PASSWORD`          | The Cassandra password                                       | `cassandra-password in ingestion-channel-credentials secret` |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_FLOWCORE_KEYSPACE` | The Cassandra Flowcore keyspace                              | `flowcore`                                                   |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_CLIENT_KEYSPACE`   | The Cassandra client keyspace                                | `flowcore_platform_data`                                     |
| `flowcore-microservices.deployments.ingestionChannel.env.LOG_LEVEL`                   | The log level                                                | `info`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_DEPLOYMENT_TYPE`    | The Flowcore deployment type, supported values: cloud, cloud | `{}`                                                         |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_API_KEY`            | The Flowcore API key                                         | `api-key in tenant-credentials secret`                       |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_WEBHOOK_BASE_URL`   | The Flowcore webhook base URL                                | `https://example.com`                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_WEBHOOK_DATA_CORE`  | The Flowcore webhook data core                               | `ecc024c5-3adf-42a3-aa55-fd3620673192`                       |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_WEBHOOK_TENANT`     | The Flowcore webhook tenant                                  | `flowcore`                                                   |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_TENANT_ID`          | The Flowcore tenant ID                                       | `tenant-id in tenant-credentials secret`                     |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_LICENSE_KEY`        | The Flowcore license key                                     | `license-key in tenant-credentials secret`                   |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_TENANT_API_URL`     | The Flowcore tenant API URL                                  | `https://tenant.api.flowcore.io`                             |

### Flowcore Legacy Client Event Source API

| Name                                                                                                       | Description                                           | Value                                                                 |
| ---------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | --------------------------------------------------------------------- |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.enabled`                                    | Whether to install the legacy client event source API | `true`                                                                |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.deployment.image`                           | The image                                             | `source-event-source`                                                 |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.deployment.tag`                             | The tag                                               | `2.10.3`                                                              |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.deployment.replicas`                        | The number of replicas                                | `2`                                                                   |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_CONTACT_POINTS`               | The Cassandra contact points                          | `flowcore-cassandra`                                                  |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_KEYSPACE`                     | The Cassandra keyspace                                | `flowcore_platform_data`                                              |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_USERNAME`                     | The Cassandra username                                | `cassandra-username in legacy-client-event-source-credentials secret` |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_PASSWORD`                     | The Cassandra password                                | `cassandra-password in legacy-client-event-source-credentials secret` |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.GRPC_URL`                               | The GRPC URL                                          | `0.0.0.0:5000`                                                        |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_DEFAULT_REPLICATION_STRATEGY` | The Cassandra default replication strategy            | `NetworkTopologyStrategy`                                             |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_DEFAULT_REPLICATION_FACTOR`   | The Cassandra default replication factor              | `3`                                                                   |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.ARCHIVE_BUCKET_NAME`                    | The archive bucket name                               | `flowcore-platform-archive`                                           |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.ARCHIVE_REGION`                         | The archive region                                    | `eu-west-1`                                                           |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.ARCHIVE_ACCESS_KEY_ID`                  | The archive access key ID                             | `aws-access-key-id in aws-credentials secret`                         |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.ARCHIVE_SECRET_ACCESS_KEY`              | The archive secret access key                         | `aws-secret-access-key in aws-credentials secret`                     |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.HOT_STORAGE_RETENTION`                  | The hot storage retention                             | `3`                                                                   |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CACHE_USE_REMOTE`                       | Whether to use the remote cache                       | `true`                                                                |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CACHE_REDIS_URL`                        | The Redis URL                                         | `redis-url in legacy-client-event-source-credentials secret`          |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.service.enabled`                            | Whether to install the service                        | `true`                                                                |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.service.extraPorts.grpc.port`               | The port for the GRPC service                         | `5000`                                                                |

### Flowcore Legacy Platform Event Source API

| Name                                                                                                         | Description                                             | Value                                                                   |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------- | ----------------------------------------------------------------------- |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.enabled`                                    | Whether to install the legacy platform event source API | `true`                                                                  |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.deployment.image`                           | The image                                               | `source-event-source`                                                   |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.deployment.tag`                             | The tag                                                 | `2.10.3`                                                                |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.deployment.replicas`                        | The number of replicas                                  | `2`                                                                     |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_CONTACT_POINTS`               | The Cassandra contact points                            | `flowcore-cassandra`                                                    |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_KEYSPACE`                     | The Cassandra keyspace                                  | `flowcore`                                                              |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_USERNAME`                     | The Cassandra username                                  | `cassandra-username in legacy-platform-event-source-credentials secret` |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_PASSWORD`                     | The Cassandra password                                  | `cassandra-password in legacy-platform-event-source-credentials secret` |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.GRPC_URL`                               | The GRPC URL                                            | `0.0.0.0:5000`                                                          |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_DEFAULT_REPLICATION_STRATEGY` | The Cassandra default replication strategy              | `NetworkTopologyStrategy`                                               |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_DEFAULT_REPLICATION_FACTOR`   | The Cassandra default replication factor                | `3`                                                                     |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.ARCHIVE_BUCKET_NAME`                    | The archive bucket name                                 | `flowcore-platform-archive`                                             |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.ARCHIVE_REGION`                         | The archive region                                      | `eu-west-1`                                                             |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.ARCHIVE_ACCESS_KEY_ID`                  | The archive access key ID                               | `aws-access-key-id in aws-credentials secret`                           |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.ARCHIVE_SECRET_ACCESS_KEY`              | The archive secret access key                           | `aws-secret-access-key in aws-credentials secret`                       |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.HOT_STORAGE_RETENTION`                  | The hot storage retention                               | `3`                                                                     |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CACHE_USE_REMOTE`                       | Whether to use the remote cache                         | `true`                                                                  |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CACHE_REDIS_URL`                        | The Redis URL                                           | `redis-url in legacy-platform-event-source-credentials secret`          |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.service.enabled`                            | Whether to install the service                          | `true`                                                                  |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.service.extraPorts.grpc.port`               | The port for the GRPC service                           | `5000`                                                                  |

### Flowcore Event Source API

| Name                                                                                | Description                             | Value                                                                                                                |
| ----------------------------------------------------------------------------------- | --------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `flowcore-microservices.deployments.eventSourceApi.enabled`                         | Whether to install the event source API | `true`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.deployment.image`                | The image                               | `source-event-source`                                                                                                |
| `flowcore-microservices.deployments.eventSourceApi.deployment.tag`                  | The tag                                 | `1.23.1`                                                                                                             |
| `flowcore-microservices.deployments.eventSourceApi.deployment.replicas`             | The number of replicas                  | `2`                                                                                                                  |
| `flowcore-microservices.deployments.eventSourceApi.service`                         | The service                             | `{}`                                                                                                                 |
| `flowcore-microservices.deployments.eventSourceApi.service.enabled`                 | Whether to enable the service           | `true`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.service.port`                    | The service port                        | `3000`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.service.extraPorts.metrics.port` | The port for the metrics                | `9000`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.service.extraPorts.metrics.type` | The type for the metrics                | `TCP`                                                                                                                |
| `flowcore-microservices.deployments.eventSourceApi.metrics.enabled`                 | Whether to enable the metrics           | `true`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.metrics.port`                    | The port for the metrics                | `9000`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.env`                             | The environment variables               | `{}`                                                                                                                 |
| `flowcore-microservices.deployments.eventSourceApi.env.LOG_LEVEL`                   | The log level                           | `info`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.env.SERVICE_PORT`                | The service port                        | `3000`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.env.POSTGRES_CONNECTION_STRING`  | The PostgreSQL connection string        | `postgres-connection-string in event-source-api-user-credentials secret`                                             |
| `flowcore-microservices.deployments.eventSourceApi.env.TRANSFORMER_SECRET`          | The transformer secret                  | `transformer-secret in service-event-source-api-credentials secret`                                                  |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_DATA_KEYSPACE`     | The Cassandra data keyspace             | `flowcore_platform_data`                                                                                             |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_FLOWCORE_KEYSPACE` | The Cassandra flowcore keyspace         | `flowcore`                                                                                                           |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_CONTACT_POINTS`    | The Cassandra contact points            | `production-cluster-datacenter1-service.datastores.svc.cluster.local in service-event-source-api-credentials secret` |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_USERNAME`          | The Cassandra username                  | `cassandra-username in service-event-source-api-credentials secret`                                                  |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_PASSWORD`          | The Cassandra password                  | `cassandra-password in service-event-source-api-credentials secret`                                                  |
| `flowcore-microservices.deployments.eventSourceApi.env.REDIS_URL`                   | The Redis URL                           | `redis-url in service-event-source-api-credentials secret`                                                           |
| `flowcore-microservices.deployments.eventSourceApi.env.REDIS_KEY_PATTERN`           | The Redis key pattern                   | `event-source-api:event-cache`                                                                                       |
| `flowcore-microservices.deployments.eventSourceApi.env.JWKS_URL`                    | The JWKS URL                            | `https://auth.flowcore.io/realms/flowcore/protocol/openid-connect/certs`                                             |
| `flowcore-microservices.deployments.eventSourceApi.env.API_KEY_URL`                 | The API key URL                         | `https://security-key.api.flowcore.io`                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.env.IAM_API_URL`                 | The IAM API URL                         | `http://service-iam-api.flowcore-public:3000`                                                                        |
| `flowcore-microservices.deployments.eventSourceApi.env.COLD_STORAGE_API_URL`        | The cold storage API URL                | `http://cold-storage-api.flowcore-source:3000`                                                                       |
| `flowcore-microservices.deployments.eventSourceApi.env.HOT_STORAGE_RETENTION_HOURS` | The hot storage retention hours         | `72`                                                                                                                 |
| `flowcore-microservices.deployments.eventSourceApi.env.DEPLOYMENT_TYPE`             | The deployment type                     | `dedicated`                                                                                                          |
| `flowcore-microservices.deployments.eventSourceApi.env.DEDICATED_TENANT_ID`         | The dedicated tenant ID                 | `tenant-id in tenant-credentials secret`                                                                             |
| `flowcore-microservices.deployments.eventSourceApi.env.DEDICATED_TENANT_NAME`       | The dedicated tenant name               | `tenant in tenant-credentials secret`                                                                                |
| `flowcore-microservices.deployments.eventSourceApi.castAiSpot`                      | The castAiSpot                          | `preferred`                                                                                                          |
| `flowcore-microservices.deployments.eventSourceApi.subdomain`                       | The subdomain                           | `event-source`                                                                                                       |
| `flowcore-microservices.deployments.eventSourceApi.ingress.annotations`             | The ingress annotations                 | `{}`                                                                                                                 |

### Event Source Active Data Pump

| Name                                                                                                                  | Description                                          | Value                                                      |
| --------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------------- |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.enabled`                                                | Whether to install the event source active data pump | `true`                                                     |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.deployment.image`                                       | The image                                            | `service-active-data-pump`                                 |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.deployment.tag`                                         | The tag                                              | `1.0.2`                                                    |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.deployment.replicas`                                    | The number of replicas                               | `1`                                                        |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.service.enabled`                                        | Whether to enable the service                        | `true`                                                     |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.metrics.enabled`                                        | Whether to enable the metrics                        | `true`                                                     |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.metrics.port`                                           | The port for the metrics                             | `3000`                                                     |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.useTransports`                                          | The useTransports                                    | `nats`                                                     |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.env.FLOWCORE_API_KEY_ID`                                | The FLOWCORE_API_KEY_ID                              | `api-key-id in tenant-credentials secret`                  |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.env.FLOWCORE_API_KEY`                                   | The FLOWCORE_API_KEY                                 | `api-key-value in tenant-credentials secret`               |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.env.REDIS_URL`                                          | The REDIS_URL                                        | `redis-sentinel-rw in event-source-api-credentials secret` |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.env.DEFAULT_DATA_PUMP_MAX_REDELIVERY_COUNT`             | The DEFAULT_DATA_PUMP_MAX_REDELIVERY_COUNT           | `-1`                                                       |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.env.REDIS_KEY_PATTERN`                                  | The REDIS_KEY_PATTERN                                | `event-source-active-data-pump`                            |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.env.ENDPOINT_HEADER_VALUE`                              | The ENDPOINT_HEADER_VALUE                            | `event-source-active-data-pump`                            |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.env.ENDPOINT_OVERRIDE_URL`                              | The ENDPOINT_OVERRIDE_URL                            | `http://event-source-api:3000`                             |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.env.NO_TRANSLATION_MODE`                                | The NO_TRANSLATION_MODE                              | `true`                                                     |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.volumes.config`                                         | The configuration                                    | `{}`                                                       |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.volumes.event-source-active-data-pump-config.mountPath` | The mount path                                       | `/usr/src/app/.config`                                     |
| `flowcore-microservices.deployments.eventSourceActiveDataPump.volumes.event-source-active-data-pump-config.type`      | The type                                             | `configMap`                                                |

### Cold Storage API

| Name                                                                               | Description                             | Value                                                                    |
| ---------------------------------------------------------------------------------- | --------------------------------------- | ------------------------------------------------------------------------ |
| `flowcore-microservices.deployments.coldStorageApi.enabled`                        | Whether to install the cold storage API | `true`                                                                   |
| `flowcore-microservices.deployments.coldStorageApi.deployment.image`               | The image                               | `service-cold-storage-api`                                               |
| `flowcore-microservices.deployments.coldStorageApi.deployment.tag`                 | The tag                                 | `2.12.1`                                                                 |
| `flowcore-microservices.deployments.coldStorageApi.deployment.replicas`            | The number of replicas                  | `2`                                                                      |
| `flowcore-microservices.deployments.coldStorageApi.deployment.resources`           | The resources                           | `{}`                                                                     |
| `flowcore-microservices.deployments.coldStorageApi.castAiSpot`                     | The castAiSpot                          | `preferred`                                                              |
| `flowcore-microservices.deployments.coldStorageApi.metrics.enabled`                | Whether to enable the metrics           | `true`                                                                   |
| `flowcore-microservices.deployments.coldStorageApi.service.enabled`                | Whether to enable the service           | `true`                                                                   |
| `flowcore-microservices.deployments.coldStorageApi.env.LOG_LEVEL`                  | The log level                           | `info`                                                                   |
| `flowcore-microservices.deployments.coldStorageApi.env.POSTGRES_CONNECTION_STRING` | The PostgreSQL connection string        | `postgres-connection-string in cold-storage-api-credentials secret`      |
| `flowcore-microservices.deployments.coldStorageApi.env.TRANSFORMER_SECRET`         | The transformer secret                  | `transformer-secret in cold-storage-api-credentials secret`              |
| `flowcore-microservices.deployments.coldStorageApi.env.JWKS_URL`                   | The JWKS URL                            | `https://auth.flowcore.io/realms/flowcore/protocol/openid-connect/certs` |
| `flowcore-microservices.deployments.coldStorageApi.env.API_KEY_URL`                | The API key URL                         | `ttps://security-key.api.flowcore.io`                                    |
| `flowcore-microservices.deployments.coldStorageApi.env.REDIS_URL`                  | The Redis URL                           | `redis-sentinel-rw in cold-storage-api-credentials secret`               |
| `flowcore-microservices.deployments.coldStorageApi.env.REDIS_KEY_PATTERN`          | The Redis key pattern                   | `cold-storage-api:event-cache`                                           |
| `flowcore-microservices.deployments.coldStorageApi.env.IAM_API_URL`                | The IAM API URL                         | `https://iam.api.flowcore.io`                                            |
| `flowcore-microservices.deployments.coldStorageApi.env.AWS_REGION`                 | The AWS region                          | `eu-west-1`                                                              |
| `flowcore-microservices.deployments.coldStorageApi.env.AWS_BUCKET_NAME`            | The AWS bucket name                     | `flowcore-platform-archive`                                              |
| `flowcore-microservices.deployments.coldStorageApi.env.AWS_ACCESS_KEY_ID`          | The archive access key ID               | `aws-access-key-id in aws-credentials secret`                            |
| `flowcore-microservices.deployments.coldStorageApi.env.AWS_SECRET_ACCESS_KEY`      | The archive secret access key           | `aws-secret-access-key in aws-credentials secret`                        |
| `flowcore-microservices.deployments.coldStorageApi.env.DEPLOYMENT_TYPE`            | The deployment type                     | `dedicated`                                                              |
| `flowcore-microservices.deployments.coldStorageApi.env.DEDICATED_TENANT_ID`        | The dedicated tenant ID                 | `tenant-id in tenant-credentials secret`                                 |
| `flowcore-microservices.deployments.coldStorageApi.env.DEDICATED_TENANT_NAME`      | The dedicated tenant name               | `tenant in tenant-credentials secret`                                    |

### Cold Storage Active Data Pump

| Name                                                                                                                   | Description                                          | Value                                                      |
| ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------------- |
| `flowcore-microservices.deployments.constStorageActiveDataPump.enabled`                                                | Whether to install the event source active data pump | `true`                                                     |
| `flowcore-microservices.deployments.constStorageActiveDataPump.deployment.image`                                       | The image                                            | `service-active-data-pump`                                 |
| `flowcore-microservices.deployments.constStorageActiveDataPump.deployment.tag`                                         | The tag                                              | `1.0.2`                                                    |
| `flowcore-microservices.deployments.constStorageActiveDataPump.deployment.replicas`                                    | The number of replicas                               | `1`                                                        |
| `flowcore-microservices.deployments.constStorageActiveDataPump.service.enabled`                                        | Whether to enable the service                        | `true`                                                     |
| `flowcore-microservices.deployments.constStorageActiveDataPump.metrics.enabled`                                        | Whether to enable the metrics                        | `true`                                                     |
| `flowcore-microservices.deployments.constStorageActiveDataPump.metrics.port`                                           | The port for the metrics                             | `3000`                                                     |
| `flowcore-microservices.deployments.constStorageActiveDataPump.useTransports`                                          | The useTransports                                    | `nats`                                                     |
| `flowcore-microservices.deployments.constStorageActiveDataPump.env.FLOWCORE_API_KEY_ID`                                | The FLOWCORE_API_KEY_ID                              | `api-key-id in tenant-credentials secret`                  |
| `flowcore-microservices.deployments.constStorageActiveDataPump.env.FLOWCORE_API_KEY`                                   | The FLOWCORE_API_KEY                                 | `api-key-value in tenant-credentials secret`               |
| `flowcore-microservices.deployments.constStorageActiveDataPump.env.REDIS_URL`                                          | The REDIS_URL                                        | `redis-sentinel-rw in cold-storage-api-credentials secret` |
| `flowcore-microservices.deployments.constStorageActiveDataPump.env.DEFAULT_DATA_PUMP_MAX_REDELIVERY_COUNT`             | The DEFAULT_DATA_PUMP_MAX_REDELIVERY_COUNT           | `-1`                                                       |
| `flowcore-microservices.deployments.constStorageActiveDataPump.env.REDIS_KEY_PATTERN`                                  | The REDIS_KEY_PATTERN                                | `cold-storage-api-credentials`                             |
| `flowcore-microservices.deployments.constStorageActiveDataPump.env.ENDPOINT_HEADER_VALUE`                              | The ENDPOINT_HEADER_VALUE                            | `cold-storage-api-credentials`                             |
| `flowcore-microservices.deployments.constStorageActiveDataPump.env.ENDPOINT_OVERRIDE_URL`                              | The ENDPOINT_OVERRIDE_URL                            | `http://event-source-api:3000`                             |
| `flowcore-microservices.deployments.constStorageActiveDataPump.env.NO_TRANSLATION_MODE`                                | The NO_TRANSLATION_MODE                              | `true`                                                     |
| `flowcore-microservices.deployments.constStorageActiveDataPump.volumes.config`                                         | The configuration                                    | `{}`                                                       |
| `flowcore-microservices.deployments.constStorageActiveDataPump.volumes.cold-storage-active-data-pump-config.mountPath` | The mount path                                       | `/usr/src/app/.config`                                     |
| `flowcore-microservices.deployments.constStorageActiveDataPump.volumes.cold-storage-active-data-pump-config.type`      | The type                                             | `configMap`                                                |

### Ingestion Validation Adapter

| Name                                                                                                                  | Description                                         | Value                                                             |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- | ----------------------------------------------------------------- |
| `flowcore-microservices.deployments.ingestionValidationAdapter.enabled`                                               | Whether to install the ingestion validation adapter | `true`                                                            |
| `flowcore-microservices.deployments.ingestionValidationAdapter.deployment.tag`                                        | The image tag                                       | `1.2.3`                                                           |
| `flowcore-microservices.deployments.ingestionValidationAdapter.deployment.image`                                      | The image                                           | `ingestion-ingestion-validation-adapter`                          |
| `flowcore-microservices.deployments.ingestionValidationAdapter.env.GRPC_URL`                                          | The GRPC URL                                        | `0.0.0.0:5000`                                                    |
| `flowcore-microservices.deployments.ingestionValidationAdapter.env.FLOWCORE_DATA_PUMP_URL`                            | The FLOWCORE_DATA_PUMP_URL                          | `localhost:5001`                                                  |
| `flowcore-microservices.deployments.ingestionValidationAdapter.env.REDIS_MASTER_SET_NAME`                             | The REDIS_MASTER_SET_NAME                           | `sentinel-primary-set in ingestion-validation-credentials secret` |
| `flowcore-microservices.deployments.ingestionValidationAdapter.env.REDIS_SENTINELS`                                   | The REDIS_SENTINELS                                 | `sentinel-hosts in ingestion-validation-credentials secret`       |
| `flowcore-microservices.deployments.ingestionValidationAdapter.env.REDIS_PASSWORD`                                    | The REDIS_PASSWORD                                  | `sentinel-password in ingestion-validation-credentials secret`    |
| `flowcore-microservices.deployments.ingestionValidationAdapter.useTransports`                                         | The useTransports                                   | `nats`                                                            |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars`                                              | The sidecars                                        | `{}`                                                              |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.tag`                                 | The image tag                                       | `5.0.0`                                                           |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.enabled`                             | Whether to enable the data pump                     | `true`                                                            |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.image`                               | The image                                           | `legacy-data-pump`                                                |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.GRPC_URL`                        | The GRPC URL                                        | `0.0.0.0:5001`                                                    |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.REDIS_HOST`                      | The REDIS_HOST                                      | `valkey-cache-primary`                                            |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.REDIS_PORT`                      | The REDIS_PORT                                      | `6379`                                                            |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.DATA_PUMP_NAME`                  | The DATA_PUMP_NAME                                  | `ingestion-validation-adapter`                                    |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.DATA_PUMP_MAX_TIME_BETWEEN_MSGS` | The DATA_PUMP_MAX_TIME_BETWEEN_MSGS                 | `10000`                                                           |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.DATA_PUMP_MAX_HISTORY_IN_HOURS`  | The DATA_PUMP_MAX_HISTORY_IN_HOURS                  | `2500`                                                            |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.DATA_PUMP_ADAPTER_URL`           | The DATA_PUMP_ADAPTER_URL                           | `localhost:5000`                                                  |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.FLOWCORE_AGGREGATOR`             | The FLOWCORE_AGGREGATOR                             | `event-type.0`                                                    |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.FLOWCORE_EVENT_TYPES`            | The FLOWCORE_EVENT_TYPES                            | `"event.event-type.created.0 event.event-type.deleted.0"`         |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.FLOWCORE_DATA_CORE_ID`           | The FLOWCORE_DATA_CORE_ID                           | `ecc024c5-3adf-42a3-aa55-fd3620673192`                            |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.FLOWCORE_EVENT_SOURCE_URL`       | The FLOWCORE_EVENT_SOURCE_URL                       | `legacy-platform-event-source-api:5000`                           |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.FLOWCORE_TENANT_ID`              | The FLOWCORE_TENANT_ID                              | `flowcore`                                                        |
| `flowcore-microservices.deployments.ingestionValidationAdapter.sidecars.dataPump.env.LOG_LEVEL`                       | The LOG_LEVEL                                       | `info`                                                            |

### Webhook Service

| Name                                                                                     | Description                            | Value                                                          |
| ---------------------------------------------------------------------------------------- | -------------------------------------- | -------------------------------------------------------------- |
| `flowcore-microservices.deployments.webhookService.enabled`                              | Whether to install the webhook service | `true`                                                         |
| `flowcore-microservices.deployments.webhookService.deployment.image`                     | The image                              | `ingestion-webhook-service`                                    |
| `flowcore-microservices.deployments.webhookService.deployment.tag`                       | The image tag                          | `1.26.3`                                                       |
| `flowcore-microservices.deployments.webhookService.deployment.replicas`                  | The number of replicas                 | `2`                                                            |
| `flowcore-microservices.deployments.webhookService.deployment.resources`                 | The resources                          | `{}`                                                           |
| `flowcore-microservices.deployments.webhookService.deployment.resources.requests.cpu`    | The CPU request                        | `328m`                                                         |
| `flowcore-microservices.deployments.webhookService.deployment.resources.requests.memory` | The memory request                     | `128Mi`                                                        |
| `flowcore-microservices.deployments.webhookService.deployment.resources.limits.cpu`      | The CPU limit                          | `2000m`                                                        |
| `flowcore-microservices.deployments.webhookService.deployment.resources.limits.memory`   | The memory limit                       | `2048Mi`                                                       |
| `flowcore-microservices.deployments.webhookService.metrics.enabled`                      | Whether to enable the metrics          | `true`                                                         |
| `flowcore-microservices.deployments.webhookService.useTransports`                        | The useTransports                      | `nats`                                                         |
| `flowcore-microservices.deployments.webhookService.env.FLOWCORE_DEPLOYMENT_TYPE`         | The FLOWCORE_DEPLOYMENT_TYPE           | `dedicated`                                                    |
| `flowcore-microservices.deployments.webhookService.env.FLOWCORE_DEDICATED_FLOWCORE_ORG`  | The FLOWCORE_DEDICATED_FLOWCORE_ORG    | `example-org`                                                  |
| `flowcore-microservices.deployments.webhookService.env.FLOWCORE_DATA_CORE_ID`            | The FLOWCORE_DATA_CORE_ID              | `ecc024c5-3adf-42a3-aa55-fd3620673192`                         |
| `flowcore-microservices.deployments.webhookService.env.REDIS_MASTER_SET_NAME`            | The REDIS_MASTER_SET_NAME              | `sentinel-primary-set in webhook-ingestion-credentials secret` |
| `flowcore-microservices.deployments.webhookService.env.REDIS_SENTINELS`                  | The REDIS_SENTINELS                    | `sentinel-hosts in webhook-ingestion-credentials secret`       |
| `flowcore-microservices.deployments.webhookService.env.REDIS_PASSWORD`                   | The REDIS_PASSWORD                     | `sentinel-password in webhook-ingestion-credentials secret`    |
| `flowcore-microservices.deployments.webhookService.env.NATS_QUEUE`                       | The NATS_QUEUE                         | `ingestion-webhook`                                            |
| `flowcore-microservices.deployments.webhookService.env.INGESTION_NATS_SERVERS`           | The INGESTION_NATS_SERVERS             | `nats://nats:4222`                                             |
| `flowcore-microservices.deployments.webhookService.env.FLOWCORE_API_KEY_URL`             | The FLOWCORE_API_KEY_URL               | `https://security-key.api.flowcore.io`                         |
| `flowcore-microservices.deployments.webhookService.service.enabled`                      | Whether to enable the service          | `true`                                                         |
| `flowcore-microservices.deployments.webhookService.service.port`                         | The service port                       | `3000`                                                         |
| `flowcore-microservices.deployments.webhookService.castAiSpot`                           | The castAiSpot                         | `preferred`                                                    |
| `flowcore-microservices.deployments.webhookService.subdomain`                            | The subdomain                          | `webhook`                                                      |
| `flowcore-microservices.deployments.webhookService.ingress.annotations`                  | The ingress annotations                | `{}`                                                           |

### Event Recorder

| Name                                                                                    | Description                           | Value                                                       |
| --------------------------------------------------------------------------------------- | ------------------------------------- | ----------------------------------------------------------- |
| `flowcore-microservices.deployments.eventRecorder.enabled`                              | Whether to install the event recorder | `true`                                                      |
| `flowcore-microservices.deployments.eventRecorder.deployment.tag`                       | The image tag                         | `1.16.0`                                                    |
| `flowcore-microservices.deployments.eventRecorder.deployment.replicas`                  | The number of replicas                | `2`                                                         |
| `flowcore-microservices.deployments.eventRecorder.deployment.image`                     | The image                             | `source-event-recorder`                                     |
| `flowcore-microservices.deployments.eventRecorder.deployment.resources`                 | The resources                         | `{}`                                                        |
| `flowcore-microservices.deployments.eventRecorder.deployment.resources.requests.cpu`    | The CPU request                       | `1024m`                                                     |
| `flowcore-microservices.deployments.eventRecorder.deployment.resources.requests.memory` | The memory request                    | `1024Mi`                                                    |
| `flowcore-microservices.deployments.eventRecorder.deployment.resources.limits.cpu`      | The CPU limit                         | `2048m`                                                     |
| `flowcore-microservices.deployments.eventRecorder.deployment.resources.limits.memory`   | The memory limit                      | `2048Mi`                                                    |
| `flowcore-microservices.deployments.eventRecorder.metrics.enabled`                      | Whether to enable the metrics         | `true`                                                      |
| `flowcore-microservices.deployments.eventRecorder.env.LOG_LEVEL`                        | The LOG_LEVEL                         | `info`                                                      |
| `flowcore-microservices.deployments.eventRecorder.env.NATS_MAX_MESSAGES`                | The NATS_MAX_MESSAGES                 | `1000`                                                      |
| `flowcore-microservices.deployments.eventRecorder.env.NATS_QUEUE`                       | The NATS_QUEUE                        | `source-event-recorder`                                     |
| `flowcore-microservices.deployments.eventRecorder.env.REDIS_MASTER_SET_NAME`            | The REDIS_MASTER_SET_NAME             | `sentinel-primary-set in event-recorder-credentials secret` |
| `flowcore-microservices.deployments.eventRecorder.env.REDIS_SENTINELS`                  | The REDIS_SENTINELS                   | `sentinel-hosts in event-recorder-credentials secret`       |
| `flowcore-microservices.deployments.eventRecorder.env.REDIS_PASSWORD`                   | The REDIS_PASSWORD                    | `sentinel-password in event-recorder-credentials secret`    |
| `flowcore-microservices.deployments.eventRecorder.env.CASSANDRA_CONTACT_POINTS`         | The CASSANDRA_CONTACT_POINTS          | `flowcore-cassandra.flowcore.svc.cluster.local`             |
| `flowcore-microservices.deployments.eventRecorder.env.CASSANDRA_KEYSPACE`               | The CASSANDRA_KEYSPACE                | `flowcore_archive`                                          |
| `flowcore-microservices.deployments.eventRecorder.env.CASSANDRA_USERNAME`               | The CASSANDRA_USERNAME                | `cassandra-username in event-recorder-credentials secret`   |
| `flowcore-microservices.deployments.eventRecorder.env.CASSANDRA_PASSWORD`               | The CASSANDRA_PASSWORD                | `cassandra-password in event-recorder-credentials secret`   |
| `flowcore-microservices.deployments.eventRecorder.env.FLOWCORE_JETSTREAM_NAME`          | The FLOWCORE_JETSTREAM_NAME           | `flowcore-stored-events`                                    |
| `flowcore-microservices.deployments.eventRecorder.env.ARANGODB_URL`                     | The ARANGODB_URL                      | `http://arango.flowcore.svc.cluster.local:8529`             |
| `flowcore-microservices.deployments.eventRecorder.env.ARANGODB_USERNAME`                | The ARANGODB_USERNAME                 | `arangodb-username in event-recorder-credentials secret`    |
| `flowcore-microservices.deployments.eventRecorder.env.ARANGODB_PASSWORD`                | The ARANGODB_PASSWORD                 | `arangodb-password in event-recorder-credentials secret`    |
| `flowcore-microservices.deployments.eventRecorder.env.ARANGODB_DATABASE`                | The ARANGODB_DATABASE                 | `archiving`                                                 |
| `flowcore-microservices.deployments.eventRecorder.env.FLOWCORE_PARALLEL_WRITE`          | The FLOWCORE_PARALLEL_WRITE           | `20`                                                        |
| `flowcore-microservices.deployments.eventRecorder.env.FLOWCORE_WRITE_BATCH_SIZE`        | The FLOWCORE_WRITE_BATCH_SIZE         | `1000`                                                      |
| `flowcore-microservices.deployments.eventRecorder.useTransports`                        | The useTransports                     | `nats`                                                      |

### Event Archiver

| Name                                                                                    | Description                           | Value                                                       |
| --------------------------------------------------------------------------------------- | ------------------------------------- | ----------------------------------------------------------- |
| `flowcore-microservices.deployments.eventArchiver.enabled`                              | Whether to install the event archiver | `true`                                                      |
| `flowcore-microservices.deployments.eventArchiver.metrics.enabled`                      | Whether to enable the metrics         | `true`                                                      |
| `flowcore-microservices.deployments.eventArchiver.deployment.image`                     | The image                             | `source-event-archiver`                                     |
| `flowcore-microservices.deployments.eventArchiver.deployment.tag`                       | The image tag                         | `1.19.0`                                                    |
| `flowcore-microservices.deployments.eventArchiver.deployment.replicas`                  | The number of replicas                | `2`                                                         |
| `flowcore-microservices.deployments.eventArchiver.deployment.resources`                 | The resources                         | `{}`                                                        |
| `flowcore-microservices.deployments.eventArchiver.deployment.resources.requests.cpu`    | The CPU request                       | `100m`                                                      |
| `flowcore-microservices.deployments.eventArchiver.deployment.resources.requests.memory` | The memory request                    | `128Mi`                                                     |
| `flowcore-microservices.deployments.eventArchiver.deployment.resources.limits.cpu`      | The CPU limit                         | `2000m`                                                     |
| `flowcore-microservices.deployments.eventArchiver.deployment.resources.limits.memory`   | The memory limit                      | `4096Mi`                                                    |
| `flowcore-microservices.deployments.eventArchiver.env.ARCHIVING_CHUNK_SIZE`             | The ARCHIVING_CHUNK_SIZE              | `10000`                                                     |
| `flowcore-microservices.deployments.eventArchiver.env.ARANGODB_URL`                     | The ARANGODB_URL                      | `http://arango.flowcore.svc.cluster.local:8529`             |
| `flowcore-microservices.deployments.eventArchiver.env.ARANGODB_USERNAME`                | The ARANGODB_USERNAME                 | `arangodb-username in event-archiver-credentials secret`    |
| `flowcore-microservices.deployments.eventArchiver.env.ARANGODB_PASSWORD`                | The ARANGODB_PASSWORD                 | `arangodb-password in event-archiver-credentials secret`    |
| `flowcore-microservices.deployments.eventArchiver.env.ARANGODB_DATABASE`                | The ARANGODB_DATABASE                 | `archiving`                                                 |
| `flowcore-microservices.deployments.eventArchiver.env.REDIS_MASTER_SET_NAME`            | The REDIS_MASTER_SET_NAME             | `sentinel-primary-set in event-archiver-credentials secret` |
| `flowcore-microservices.deployments.eventArchiver.env.REDIS_SENTINELS`                  | The REDIS_SENTINELS                   | `sentinel-hosts in event-archiver-credentials secret`       |
| `flowcore-microservices.deployments.eventArchiver.env.REDIS_PASSWORD`                   | The REDIS_PASSWORD                    | `sentinel-password in event-archiver-credentials secret`    |
| `flowcore-microservices.deployments.eventArchiver.env.ARCHIVING_ACCESS_KEY_ID`          | The ARCHIVING_ACCESS_KEY_ID           | `aws-access-key-id in aws-credentials secret`               |
| `flowcore-microservices.deployments.eventArchiver.env.ARCHIVING_SECRET_ACCESS_KEY`      | The ARCHIVING_SECRET_ACCESS_KEY       | `aws-secret-access-key in aws-credentials secret`           |
| `flowcore-microservices.deployments.eventArchiver.env.ARCHIVING_BUCKET_NAME`            | The ARCHIVING_BUCKET_NAME             | `flowcore-archive`                                          |
| `flowcore-microservices.deployments.eventArchiver.env.ARCHIVING_REGION`                 | The ARCHIVING_REGION                  | `eu-west-1`                                                 |
| `flowcore-microservices.deployments.eventArchiver.env.ARCHIVING_CONCURRENT_PROCESSES`   | The ARCHIVING_CONCURRENT_PROCESSES    | `5`                                                         |
| `flowcore-microservices.deployments.eventArchiver.env.ARCHIVING_DEPLOYMENT_TYPE`        | The ARCHIVING_DEPLOYMENT_TYPE         | `dedicated`                                                 |
| `flowcore-microservices.deployments.eventArchiver.env.CASSANDRA_CONTACT_POINTS`         | The CASSANDRA_CONTACT_POINTS          | `flowcore-cassandra.flowcore.svc.cluster.local`             |
| `flowcore-microservices.deployments.eventArchiver.env.CASSANDRA_KEYSPACE`               | The CASSANDRA_KEYSPACE                | `flowcore_archive`                                          |
| `flowcore-microservices.deployments.eventArchiver.env.CASSANDRA_USERNAME`               | The CASSANDRA_USERNAME                | `cassandra-username in event-archiver-credentials secret`   |
| `flowcore-microservices.deployments.eventArchiver.env.CASSANDRA_PASSWORD`               | The CASSANDRA_PASSWORD                | `cassandra-password in event-archiver-credentials secret`   |

### Resource Lock Manager

| Name                                                                         | Description                                  | Value                        |
| ---------------------------------------------------------------------------- | -------------------------------------------- | ---------------------------- |
| `flowcore-microservices.deployments.resourceLockManager.enabled`             | Whether to install the resource lock manager | `true`                       |
| `flowcore-microservices.deployments.resourceLockManager.metrics.enabled`     | Whether to enable the metrics                | `true`                       |
| `flowcore-microservices.deployments.resourceLockManager.deployment.image`    | The image                                    | `core-resource-lock-manager` |
| `flowcore-microservices.deployments.resourceLockManager.deployment.tag`      | The image tag                                | `1.1.0`                      |
| `flowcore-microservices.deployments.resourceLockManager.deployment.replicas` | The number of replicas                       | `2`                          |
| `flowcore-microservices.deployments.resourceLockManager.env.NATS_QUEUE`      | The NATS_QUEUE                               | `resource-lock-manager`      |
| `flowcore-microservices.deployments.resourceLockManager.env.REDIS_HOST`      | The REDIS_HOST                               | `valkey-cache-primary`       |
| `flowcore-microservices.deployments.resourceLockManager.env.REDIS_PORT`      | The REDIS_PORT                               | `6379`                       |
| `flowcore-microservices.deployments.resourceLockManager.useTransports`       | The useTransports                            | `nats`                       |

### Service Kube Log API

| Name                                                                                    | Description                                 | Value                                                                    |
| --------------------------------------------------------------------------------------- | ------------------------------------------- | ------------------------------------------------------------------------ |
| `flowcore-microservices.deployments.serviceKubeLogApi.enabled`                          | Whether to install the service kube log api | `true`                                                                   |
| `flowcore-microservices.deployments.serviceKubeLogApi.deployment.replicas`              | The number of replicas                      | `2`                                                                      |
| `flowcore-microservices.deployments.serviceKubeLogApi.deployment.tag`                   | The image tag                               | `1.4.1`                                                                  |
| `flowcore-microservices.deployments.serviceKubeLogApi.deployment.image`                 | The image                                   | `service-kube-log-api`                                                   |
| `flowcore-microservices.deployments.serviceKubeLogApi.deployment.serviceAccount`        | The service account                         | `flowcore-kube-log-reader`                                               |
| `flowcore-microservices.deployments.serviceKubeLogApi.service.enabled`                  | Whether to enable the service               | `true`                                                                   |
| `flowcore-microservices.deployments.serviceKubeLogApi.service.port`                     | The service port                            | `3000`                                                                   |
| `flowcore-microservices.deployments.serviceKubeLogApi.env.NODE_TLS_REJECT_UNAUTHORIZED` | The NODE_TLS_REJECT_UNAUTHORIZED            | `0`                                                                      |
| `flowcore-microservices.deployments.serviceKubeLogApi.env.JWKS_URL`                     | The JWKS_URL                                | `https://auth.flowcore.io/realms/flowcore/protocol/openid-connect/certs` |
| `flowcore-microservices.deployments.serviceKubeLogApi.env.IAM_API_URL`                  | The IAM_API_URL                             | `https://iam.api.flowcore.io`                                            |
| `flowcore-microservices.deployments.serviceKubeLogApi.castAiSpot`                       | The castAiSpot                              | `preferred`                                                              |
| `flowcore-microservices.deployments.serviceKubeLogApi.subdomain`                        | The subdomain                               | `logs`                                                                   |
| `flowcore-microservices.deployments.serviceKubeLogApi.ingress.annotations`              | The ingress annotations                     | `{}`                                                                     |

### Service Delete Manager API

| Name                                                                                                 | Description                                       | Value                                                                    |
| ---------------------------------------------------------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------------------------------ |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.enabled`                                 | Whether to install the service delete manager api | `false`                                                                  |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.deployment.image`                        | The image                                         | `service-delete-manager-api`                                             |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.deployment.tag`                          | The image tag                                     | `1.1.1`                                                                  |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.deployment.replicas`                     | The number of replicas                            | `2`                                                                      |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.service.enabled`                         | Whether to enable the service                     | `true`                                                                   |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.service.port`                            | The service port                                  | `3000`                                                                   |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.LOG_LEVEL`                           | The LOG_LEVEL                                     | `info`                                                                   |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.SERVICE_PORT`                        | The SERVICE_PORT                                  | `3000`                                                                   |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.FLOWCORE_DEPLOYMENT_TYPE`            | The FLOWCORE_DEPLOYMENT_TYPE                      | `dedicated`                                                              |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.FLOWCORE_API_KEY`                    | The FLOWCORE_API_KEY                              | `api-key in tenant-credentials secret`                                   |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.FLOWCORE_TENANT_API_URL`             | The FLOWCORE_TENANT_API_URL                       | `https://tenant.api.flowcore.io`                                         |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.FLOWCORE_DEDICATED_TENANT_ID`        | The FLOWCORE_DEDICATED_TENANT_ID                  | `tenant-id in tenant-credentials secret`                                 |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.FLOWCORE_DEDICATED_LICENSE_KEY`      | The FLOWCORE_DEDICATED_LICENSE_KEY                | `license-key in tenant-credentials secret`                               |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.SDK_API_KEY`                         | The SDK_API_KEY                                   | `api-key in tenant-credentials secret`                                   |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.SDK_API_KEY_ID`                      | The SDK_API_KEY_ID                                | `api-key-id in tenant-credentials`                                       |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.LOCK_REDIS_URL`                      | The LOCK_REDIS_URL                                | `redis-url in delete-manager-credentials secret`                         |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.QUEUE_REDIS_URL`                     | The QUEUE_REDIS_URL                               | `redis-sentinel-rw in delete-manager-credentials secret`                 |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.QUEUE_NAME`                          | The QUEUE_NAME                                    | `delete-manager-queue`                                                   |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.CASSANDRA_LOCAL_DATA_CENTER`         | The CASSANDRA_LOCAL_DATA_CENTER                   | `datacenter1`                                                            |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.CASSANDRA_CONSISTENCY`               | The CASSANDRA_CONSISTENCY                         | `6`                                                                      |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.CASSANDRA_CONTACT_POINTS`            | The CASSANDRA_CONTACT_POINTS                      | `flowcore-cassandra.flowcore.svc.cluster.local`                          |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.CASSANDRA_KEYSPACE`                  | The CASSANDRA_KEYSPACE                            | `flowcore_archive`                                                       |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.CASSANDRA_USERNAME`                  | The CASSANDRA_USERNAME                            | `cassandra-username in delete-manager-credentials secret`                |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.CASSANDRA_PASSWORD`                  | The CASSANDRA_PASSWORD                            | `cassandra-password in delete-manager-credentials`                       |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.EVENT_STORAGE_TYPE`                  | The EVENT_STORAGE_TYPE                            | `aws`                                                                    |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.EVENT_STORAGE_BUCKET`                | The EVENT_STORAGE_BUCKET                          | `flowcore-platform-archive`                                              |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.EVENT_STORAGE_AWS_ACCESS_KEY_ID`     | The EVENT_STORAGE_AWS_ACCESS_KEY_ID               | `aws-access-key-id in aws-credentials secret`                            |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.EVENT_STORAGE_AWS_SECRET_ACCESS_KEY` | The EVENT_STORAGE_AWS_SECRET_ACCESS_KEY           | `aws-secret-access-key in aws-credentials secret`                        |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.EVENT_STORAGE_AWS_REGION`            | The EVENT_STORAGE_AWS_REGION                      | `eu-west-1`                                                              |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.JWKS_URL`                            | The JWKS_URL                                      | `https://auth.flowcore.io/realms/flowcore/protocol/openid-connect/certs` |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.API_KEY_URL`                         | The API_KEY_URL                                   | `https://security-key.api.flowcore.io`                                   |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.env.IAM_API_URL`                         | The IAM_API_URL                                   | `https://iam.api.flowcore.io`                                            |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.castAiSpot`                              | The castAiSpot                                    | `preferred`                                                              |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.subdomain`                               | The subdomain                                     | `delete-manager`                                                         |
| `flowcore-microservices.deployments.serviceDeleteManagerApi.ingress.annotations`                     | The ingress annotations                           | `{}`                                                                     |

### Service Dedicated Configurator

| Name                                                                                                          | Description                                           | Value                                      |
| ------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------ |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.enabled`                                     | Whether to install the service dedicated configurator | `true`                                     |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.deployment.image`                            | The image                                             | `service-dedicated-configurator`           |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.deployment.tag`                              | The image tag                                         | `1.1.16`                                   |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.deployment.replicas`                         | The number of replicas                                | `1`                                        |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.deployment.serviceAccount`                   | The service account                                   | `dedicated-configurator-sa`                |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.SCHEDULER_ENABLED`                       | Whether to enable the scheduler                       | `"true"`                                   |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.SCHEDULER_CRON`                          | The scheduler cron                                    | `"*/30 * * * * *"`                         |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.TENANT_API_KEY`                          | The TENANT_API_KEY                                    | `api-key in tenant-credentials secret`     |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.TENANT_API_KEY_ID`                       | The TENANT_API_KEY_ID                                 | `api-key-id in tenant-credentials secret`  |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.TENANT_LICENSE_KEY`                      | The TENANT_LICENSE_KEY                                | `license-key in tenant-credentials secret` |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.TENANT_ID`                               | The TENANT_ID                                         | `tenant-id in tenant-credentials secret`   |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.FLOWCORE_DATA_CORE_ID`                   | The FLOWCORE_DATA_CORE_ID                             | `ecc024c5-3adf-42a3-aa55-fd3620673192`     |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.TENANT_DEDICATED_DOMAIN`                 | The TENANT_DEDICATED_DOMAIN                           | `example.com`                              |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.TENANT_DEDICATED_CONFIGURATION_REPO_URL` | The TENANT_DEDICATED_CONFIGURATION_REPO_URL           | `https://configuration.api.flowcore.io`    |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.env.TENANT_DEDICATED_CONFIGURATION_PATH`     | The TENANT_DEDICATED_CONFIGURATION_PATH               | `".config/"`                               |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.volumes.secret`                              | The configuration secret                              | `{}`                                       |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.volumes.secret.secret`                       | The secret name                                       | `dedicated-configuration`                  |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.volumes.mountPath`                           | The mount path                                        | `/usr/src/app/.config`                     |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.volumes.subPath`                             | The sub path                                          | `github-private-key`                       |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.volumes.type`                                | The type                                              | `secret`                                   |
| `flowcore-microservices.deployments.serviceDedicatedConfigurator.castAiSpot`                                  | The castAiSpot                                        | `preferred`                                |



See [values.yaml](values.yaml) for the full list of parameters.
