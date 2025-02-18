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

| Name                                  | Description                | Value |
| ------------------------------------- | -------------------------- | ----- |
| `flowcore.keyspace`                   | The keyspace configuration | `{}`  |
| `flowcore.keyspace.replicationFactor` | The number of replicas     | `3`   |

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
| `cassandra.initDBConfigMap`           | The name of the config map to use for initializing the database            | `platform-source-initdb`         |

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

### PostgreSQL HA Configuration

| Name                                      | Description                                                           | Value           |
| ----------------------------------------- | --------------------------------------------------------------------- | --------------- |
| `postgresql-ha.enabled`                   | Whether to install the PostgreSQL HA instance                         | `true`          |
| `postgresql-ha.nameOverride`              | The name override                                                     | `postgresql-ha` |
| `postgresql-ha.fullnameOverride`          | The full name override                                                | `postgresql-ha` |
| `postgresql-ha.postgresql`                | The PostgreSQL configuration                                          | `{}`            |
| `postgresql-ha.postgresql.existingSecret` | The name of the existing secret containing the PostgreSQL credentials | `postgresql-ha` |
| `postgresql-ha.pgpool`                    | The pgPool configuration                                              | `{}`            |
| `postgresql-ha.pgpool.existingSecret`     | The name of the existing secret containing the pgPool credentials     | `postgresql-ha` |
| `postgresql-ha.pgpool.replicaCount`       | The number of replicas                                                | `3`             |
| `postgresql-ha.persistence.enabled`       | Whether to install the persistence                                    | `true`          |
| `postgresql-ha.persistence.size`          | The size of the persistent volume                                     | `200Gi`         |
| `postgresql-ha.persistence.storageClass`  | The storage class for the persistent volume                           |                 |
| `postgresql-ha.metrics.enabled`           | Whether to install the metrics                                        | `true`          |
| `postgresql-ha.metrics.annotations`       | The annotations for the metrics                                       | `{}`            |

### Ensure Credentials

| Name                                          | Description                                  | Value                                         |
| --------------------------------------------- | -------------------------------------------- | --------------------------------------------- |
| `ensureCredentials.image.repository`          | The image repository                         | `flowcoreio/job-create-dedicated-credentials` |
| `ensureCredentials.image.tag`                 | The image tag                                | `1.3.0`                                       |
| `ensureCredentials.resources`                 | The resources for the ensure credentials job | `{}`                                          |
| `ensureCredentials.resources.limits.cpu`      | The CPU limit                                | `100m`                                        |
| `ensureCredentials.resources.limits.cpu`      | The CPU limit                                | `100m`                                        |
| `ensureCredentials.resources.limits.memory`   | The memory limit                             | `128Mi`                                       |
| `ensureCredentials.resources.requests.cpu`    | The CPU request                              | `50m`                                         |
| `ensureCredentials.resources.requests.cpu`    | The CPU request                              | `50m`                                         |
| `ensureCredentials.resources.requests.memory` | The memory request                           | `64Mi`                                        |

### Flowcore Platform Common Configuration

| Name                                                       | Description                                       | Value                                                                       |
| ---------------------------------------------------------- | ------------------------------------------------- | --------------------------------------------------------------------------- |
| `flowcore-microservices.enabled`                           | Whether to install the Flowcore Platform Services | `true`                                                                      |
| `flowcore-microservices.imageRepository`                   | The image repository                              | `flowcore-io`                                                               |
| `flowcore-microservices.oidcWellKnownUrl`                  | The OIDC well-known URL                           | `https://auth.flowcore.io/realms/flowcore/.well-known/openid-configuration` |
| `flowcore-microservices.transport.nats.NATS_SERVERS.value` | The NATS servers                                  | `nats://nats:4222`                                                          |

### Flowcore Ingestion Channel

| Name                                                                                  | Description                                                      | Value                                                        |
| ------------------------------------------------------------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------ |
| `flowcore-microservices.deployments.ingestionChannel.enabled`                         | Whether to install the Ingestion Channel instance                | `true`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.deployment.image`                | The image                                                        | `service-ingestion`                                          |
| `flowcore-microservices.deployments.ingestionChannel.deployment.tag`                  | The tag                                                          | `1.1.0`                                                      |
| `flowcore-microservices.deployments.ingestionChannel.deployment.replicas`             | The number of replicas                                           | `2`                                                          |
| `flowcore-microservices.deployments.ingestionChannel.metrics.enabled`                 | Whether to install the metrics                                   | `true`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.metrics.port`                    | The port                                                         | `3001`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.useTransports`                   | The transports to use                                            | `nats`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.env.REDIS_URL`                   | The Redis URL                                                    | `{}`                                                         |
| `flowcore-microservices.deployments.ingestionChannel.env.METRICS_SERVICE_NAME`        | The metrics service name                                         | `ingestion_channel`                                          |
| `flowcore-microservices.deployments.ingestionChannel.env.DEFAULT_TTL_ON_STORED_EVENT` | The default TTL on stored event in seconds                       | `259200`                                                     |
| `flowcore-microservices.deployments.ingestionChannel.env.NATS_QUEUE`                  | The NATS queue                                                   |                                                              |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_CONTACT_POINTS`    | The Cassandra contact points                                     | `flowcore-cassandra`                                         |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_USERNAME`          | The Cassandra username                                           | `cassandra-username in ingestion-channel-credentials secret` |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_PASSWORD`          | The Cassandra password                                           | `cassandra-password in ingestion-channel-credentials secret` |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_FLOWCORE_KEYSPACE` | The Cassandra Flowcore keyspace                                  | `flowcore`                                                   |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_CLIENT_KEYSPACE`   | The Cassandra client keyspace                                    | `flowcore_platform_data`                                     |
| `flowcore-microservices.deployments.ingestionChannel.env.LOG_LEVEL`                   | The log level                                                    | `info`                                                       |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_DEPLOYMENT_TYPE`    | The Flowcore deployment type, supported values: dedicated, cloud | `{}`                                                         |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_TENANT_ID`          | The Flowcore tenant ID                                           | `tenant-id in tenant-credentials secret`                     |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_TENANT_API_URL`     | The Flowcore tenant API URL                                      | `https://tenant.api.flowcore.io`                             |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_API_KEY`            | The Flowcore API key                                             | `api-key in tenant-credentials secret`                       |

### Flowcore Legacy Client Event Source API

| Name                                                                                                       | Description                                           | Value                                                                        |
| ---------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------- |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.enabled`                                    | Whether to install the legacy client event source API | `true`                                                                       |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.deployment.image`                           | The image                                             | `source-event-source`                                                        |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.deployment.tag`                             | The tag                                               | `2.10.3`                                                                     |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.deployment.replicas`                        | The number of replicas                                | `2`                                                                          |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_CONTACT_POINTS`               | The Cassandra contact points                          | `flowcore-cassandra`                                                         |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_KEYSPACE`                     | The Cassandra keyspace                                | `flowcore_platform_data`                                                     |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_USERNAME`                     | The Cassandra username                                | `cassandra-username in legacy-client-event-source-credentials secret`        |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_PASSWORD`                     | The Cassandra password                                | `cassandra-password in legacy-client-event-source-credentials secret`        |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.GRPC_URL`                               | The GRPC URL                                          | `0.0.0.0:5000`                                                               |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_DEFAULT_REPLICATION_STRATEGY` | The Cassandra default replication strategy            | `NetworkTopologyStrategy`                                                    |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CASSANDRA_DEFAULT_REPLICATION_FACTOR`   | The Cassandra default replication factor              | `3`                                                                          |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.ARCHIVE_BUCKET_NAME`                    | The archive bucket name                               | `flowcore-platform-archive`                                                  |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.ARCHIVE_REGION`                         | The archive region                                    | `eu-west-1`                                                                  |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.ARCHIVE_ACCESS_KEY_ID`                  | The archive access key ID                             | `archive-access-key-id in legacy-client-event-source-credentials secret`     |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.ARCHIVE_SECRET_ACCESS_KEY`              | The archive secret access key                         | `archive-secret-access-key in legacy-client-event-source-credentials secret` |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.HOT_STORAGE_RETENTION`                  | The hot storage retention                             | `3`                                                                          |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CACHE_USE_REMOTE`                       | Whether to use the remote cache                       | `true`                                                                       |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.env.CACHE_REDIS_URL`                        | The Redis URL                                         | `redis-url in legacy-client-event-source-credentials secret`                 |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.service.enabled`                            | Whether to install the service                        | `true`                                                                       |
| `flowcore-microservices.deployments.legacyClientEventSourceApi.service.extraPorts.grpc.port`               | The port for the GRPC service                         | `5000`                                                                       |

### Flowcore Legacy Platform Event Source API

| Name                                                                                                         | Description                                             | Value                                                                        |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.enabled`                                    | Whether to install the legacy platform event source API | `true`                                                                       |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.deployment.image`                           | The image                                               | `source-event-source`                                                        |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.deployment.tag`                             | The tag                                                 | `2.10.3`                                                                     |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.deployment.replicas`                        | The number of replicas                                  | `2`                                                                          |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_CONTACT_POINTS`               | The Cassandra contact points                            | `flowcore-cassandra`                                                         |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_KEYSPACE`                     | The Cassandra keyspace                                  | `flowcore`                                                                   |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_USERNAME`                     | The Cassandra username                                  | `cassandra-username in legacy-platform-event-source-credentials secret`      |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_PASSWORD`                     | The Cassandra password                                  | `cassandra-password in legacy-platform-event-source-credentials secret`      |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.GRPC_URL`                               | The GRPC URL                                            | `0.0.0.0:5000`                                                               |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_DEFAULT_REPLICATION_STRATEGY` | The Cassandra default replication strategy              | `NetworkTopologyStrategy`                                                    |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CASSANDRA_DEFAULT_REPLICATION_FACTOR`   | The Cassandra default replication factor                | `3`                                                                          |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.ARCHIVE_BUCKET_NAME`                    | The archive bucket name                                 | `flowcore-platform-archive`                                                  |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.ARCHIVE_REGION`                         | The archive region                                      | `eu-west-1`                                                                  |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.ARCHIVE_ACCESS_KEY_ID`                  | The archive access key ID                               | `archive-access-key-id in legacy-client-event-source-credentials secret`     |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.ARCHIVE_SECRET_ACCESS_KEY`              | The archive secret access key                           | `archive-secret-access-key in legacy-client-event-source-credentials secret` |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.HOT_STORAGE_RETENTION`                  | The hot storage retention                               | `3`                                                                          |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CACHE_USE_REMOTE`                       | Whether to use the remote cache                         | `true`                                                                       |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.env.CACHE_REDIS_URL`                        | The Redis URL                                           | `redis-url in legacy-platform-event-source-credentials secret`               |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.service.enabled`                            | Whether to install the service                          | `true`                                                                       |
| `flowcore-microservices.deployments.legacyPlatformEventSourceApi.service.extraPorts.grpc.port`               | The port for the GRPC service                           | `5000`                                                                       |

### Flowcore Event Source API

| Name                                                                                | Description                             | Value                                                                                                                |
| ----------------------------------------------------------------------------------- | --------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `flowcore-microservices.deployments.eventSourceApi.enabled`                         | Whether to install the event source API | `true`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.deployment.image`                | The image                               | `source-event-source`                                                                                                |
| `flowcore-microservices.deployments.eventSourceApi.deployment.tag`                  | The tag                                 | `1.17.3`                                                                                                             |
| `flowcore-microservices.deployments.eventSourceApi.deployment.replicas`             | The number of replicas                  | `2`                                                                                                                  |
| `flowcore-microservices.deployments.eventSourceApi.service`                         | The service                             | `{}`                                                                                                                 |
| `flowcore-microservices.deployments.eventSourceApi.service.enabled`                 | Whether to enable the service           | `true`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.service.extraPorts.metrics.port` | The port for the metrics                | `9000`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.service.extraPorts.metrics.type` | The type for the metrics                | `TCP`                                                                                                                |
| `flowcore-microservices.deployments.eventSourceApi.metrics.enabled`                 | Whether to enable the metrics           | `true`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.metrics.port`                    | The port for the metrics                | `9000`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.env`                             | The environment variables               | `{}`                                                                                                                 |
| `flowcore-microservices.deployments.eventSourceApi.env.LOG_LEVEL`                   | The log level                           | `info`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.env.SERVICE_PORT`                | The service port                        | `3000`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.env.POSTGRES_CONNECTION_STRING`  | The PostgreSQL connection string        | `postgres-connection-string in service-event-source-api-credentials secret`                                          |
| `flowcore-microservices.deployments.eventSourceApi.env.TRANSFORMER_SECRET`          | The transformer secret                  | `transformer-secret in service-event-source-api-credentials secret`                                                  |
| `flowcore-microservices.deployments.eventSourceApi.env.FLOWCORE_API_KEY`            | The Flowcore API key                    | `flowcore-api-key in service-event-source-api-credentials secret`                                                    |
| `flowcore-microservices.deployments.eventSourceApi.env.FLOWCORE_TENANT`             | The Flowcore tenant                     | `flowcore in service-event-source-api-credentials secret`                                                            |
| `flowcore-microservices.deployments.eventSourceApi.env.FLOWCORE_DATA_CORE`          | The Flowcore data core                  | `ecc024c5-3adf-42a3-aa55-fd3620673192 in service-event-source-api-credentials secret`                                |
| `flowcore-microservices.deployments.eventSourceApi.env.FLOWCORE_WEBHOOK_BASE_URL`   | The Flowcore webhook base URL           | `https://flowcore.webhook.flowcore.io`                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_DATA_KEYSPACE`     | The Cassandra data keyspace             | `flowcore_platform_data`                                                                                             |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_FLOWCORE_KEYSPACE` | The Cassandra flowcore keyspace         | `flowcore`                                                                                                           |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_CONTACT_POINTS`    | The Cassandra contact points            | `production-cluster-datacenter1-service.datastores.svc.cluster.local in service-event-source-api-credentials secret` |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_USERNAME`          | The Cassandra username                  | `cassandra-username in service-event-source-api-credentials secret`                                                  |
| `flowcore-microservices.deployments.eventSourceApi.env.CASSANDRA_PASSWORD`          | The Cassandra password                  | `cassandra-password in service-event-source-api-credentials secret`                                                  |
| `flowcore-microservices.deployments.eventSourceApi.env.REDIS_URL`                   | The Redis URL                           | `redis-url in service-event-source-api-credentials secret`                                                           |
| `flowcore-microservices.deployments.eventSourceApi.env.REDIS_KEY_PATTERN`           | The Redis key pattern                   | `event-source-api:event-cache`                                                                                       |
| `flowcore-microservices.deployments.eventSourceApi.env.JWKS_URL`                    | The JWKS URL                            | `https://auth.flowcore.io/realms/flowcore/protocol/openid-connect/certs`                                             |
| `flowcore-microservices.deployments.eventSourceApi.env.API_KEY_URL`                 | The API key URL                         | `http://organization-api-key-api.flowcore-security.svc.cluster.local:3000`                                           |
| `flowcore-microservices.deployments.eventSourceApi.env.IAM_API_URL`                 | The IAM API URL                         | `http://service-iam-api.flowcore-public:3000`                                                                        |
| `flowcore-microservices.deployments.eventSourceApi.env.IAM_REDIS_URL`               | The IAM Redis URL                       | `iam-redis-url in service-event-source-api-credentials secret`                                                       |
| `flowcore-microservices.deployments.eventSourceApi.env.COLD_STORAGE_API_URL`        | The cold storage API URL                | `http://cold-storage-api.flowcore-source:3000`                                                                       |
| `flowcore-microservices.deployments.eventSourceApi.env.HOT_STORAGE_RETENTION_HOURS` | The hot storage retention hours         | `72`                                                                                                                 |
| `flowcore-microservices.deployments.eventSourceApi.env.COLD_STORAGE_BUCKET_NAME`    | The cold storage bucket name            | `flowcore-platform-cold-storage`                                                                                     |
| `flowcore-microservices.deployments.eventSourceApi.env.COLD_STORAGE_REGION`         | The cold storage region                 | `eu-west-1`                                                                                                          |
| `flowcore-microservices.deployments.eventSourceApi.env.COLD_STORAGE_ACCESS_KEY_ID`  | The cold storage access key ID          | `cold-storage-access-key-id in service-event-source-api-credentials secret`                                          |
| `flowcore-microservices.deployments.eventSourceApi.affinity`                        | The affinity                            | `{}`                                                                                                                 |
| `flowcore-microservices.deployments.eventSourceApi.ingress.enabled`                 | The ingress                             | `{}`                                                                                                                 |
| `flowcore-microservices.deployments.eventSourceApi.ingress.enabled`                 | Whether to install the ingress          | `true`                                                                                                               |
| `flowcore-microservices.deployments.eventSourceApi.ingress.annotations`             | The ingress annotations                 | `{}`                                                                                                                 |
| `flowcore-microservices.deployments.eventSourceApi.ingress.route`                   | The ingress route                       | `{}`                                                                                                                 |



See [values.yaml](values.yaml) for the full list of parameters.
