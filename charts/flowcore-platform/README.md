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

### Valkey Configuration

| Name                                             | Description                                                  | Value                           |
| ------------------------------------------------ | ------------------------------------------------------------ | ------------------------------- |
| `valkey-ha.enabled`                              | Whether to install the Valkey HA instance                    | `true`                          |
| `valkey-ha.nameOverride`                         | The name override                                            | `valkey-ha`                     |
| `valkey-ha.fullnameOverride`                     | The full name override                                       | `valkey-ha`                     |
| `valkey-ha.architecture`                         | The architecture to use                                      | `replication`                   |
| `valkey-ha.sentinel.enabled`                     | Whether to install the Sentinel instance                     | `true`                          |
| `valkey-ha.sentinel.masterSet`                   | The master set to use                                        | `fcmprimary`                    |
| `valkey-ha.sentinel.resources`                   | The resources for the Sentinel instance                      |                                 |
| `valkey-ha.auth.enabled`                         | Whether to install the Auth instance                         | `true`                          |
| `valkey-ha.auth.sentinel`                        | Whether to use the Sentinel instance                         | `true`                          |
| `valkey-ha.auth.existingSecret`                  | The name of the existing secret containing the Auth password | `platform-source-valkey-ha`     |
| `valkey-ha.auth.existingSecretPasswordKey`       | The key in the existing secret containing the Auth password  | `password`                      |
| `valkey-ha.primary.enabled`                      | Whether to install the primary instance                      | `true`                          |
| `valkey-ha.primary.replicaCount`                 | The number of replicas                                       | `1`                             |
| `valkey-ha.primary.resources`                    | The resources for the primary instance                       |                                 |
| `valkey-ha.primary.persistence.enabled`          | Whether to install the persistence                           | `true`                          |
| `valkey-ha.primary.persistence.size`             | The size of the persistent volume                            | `50Gi`                          |
| `valkey-ha.primary.persistence.storageClass`     | The storage class for the persistent volume                  |                                 |
| `valkey-ha.replica.enabled`                      | Whether to install the replica instance                      | `true`                          |
| `valkey-ha.replica.replicaCount`                 | The number of replicas                                       | `3`                             |
| `valkey-ha.replica.resources`                    | The resources for the replica instance                       |                                 |
| `valkey-ha.replica.persistence.enabled`          | Whether to install the persistence                           | `true`                          |
| `valkey-ha.replica.persistence.size`             | The size of the persistent volume                            | `50Gi`                          |
| `valkey-ha.replica.persistence.storageClass`     | The storage class for the persistent volume                  |                                 |
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

### Flowcore Platform Services

| Name                                                                                  | Description                                                      | Value                                                                       |
| ------------------------------------------------------------------------------------- | ---------------------------------------------------------------- | --------------------------------------------------------------------------- |
| `flowcore-microservices.enabled`                                                      | Whether to install the Flowcore Platform Services                | `true`                                                                      |
| `flowcore-microservices.imageRepository`                                              | The image repository                                             | `flowcore-io`                                                               |
| `flowcore-microservices.oidcWellKnownUrl`                                             | The OIDC well-known URL                                          | `https://auth.flowcore.io/realms/flowcore/.well-known/openid-configuration` |
| `flowcore-microservices.transport.nats.NATS_SERVERS.value`                            | The NATS servers                                                 | `nats://nats:4222`                                                          |
| `flowcore-microservices.deployments.ingestionChannel.enabled`                         | Whether to install the Ingestion Channel instance                | `true`                                                                      |
| `flowcore-microservices.deployments.ingestionChannel.deployment.image`                | The image                                                        | `service-ingestion`                                                         |
| `flowcore-microservices.deployments.ingestionChannel.deployment.tag`                  | The tag                                                          | `1.1.0`                                                                     |
| `flowcore-microservices.deployments.ingestionChannel.deployment.replicas`             | The number of replicas                                           | `1`                                                                         |
| `flowcore-microservices.deployments.ingestionChannel.metrics.enabled`                 | Whether to install the metrics                                   | `true`                                                                      |
| `flowcore-microservices.deployments.ingestionChannel.metrics.port`                    | The port                                                         | `3001`                                                                      |
| `flowcore-microservices.deployments.ingestionChannel.useTransports`                   | ] The transports to use                                          | `""`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.REDIS_URL`                   | The Redis URL                                                    | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.DEFAULT_TTL_ON_STORED_EVENT` | The default TTL on stored event in seconds                       | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.NATS_QUEUE`                  | The NATS queue                                                   |                                                                             |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_CONTACT_POINTS`    | The Cassandra contact points                                     | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_USERNAME`          | The Cassandra username                                           | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_PASSWORD`          | The Cassandra password                                           | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_FLOWCORE_KEYSPACE` | The Cassandra Flowcore keyspace                                  | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.CASSANDRA_CLIENT_KEYSPACE`   | The Cassandra client keyspace                                    | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.LOG_LEVEL`                   | The log level                                                    | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_DEPLOYMENT_TYPE`    | The Flowcore deployment type, supported values: dedicated, cloud | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_TENANT_ID`          | The Flowcore tenant ID                                           | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_TENANT_API_URL`     | The Flowcore tenant API URL                                      | `{}`                                                                        |
| `flowcore-microservices.deployments.ingestionChannel.env.FLOWCORE_API_KEY`            | The Flowcore API key                                             | `{}`                                                                        |



See [values.yaml](values.yaml) for the full list of parameters.
