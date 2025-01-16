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

See [values.yaml](values.yaml) for the full list of parameters.
