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

### K8ssandra configuration

| Name                                                         | Description                                                                                                                                                                                     | Value                            |
| ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- |
| `k8ssandra-operator.fullnameOverride`                        | The full name of the k8ssandra-operator deployment                                                                                                                                              | `k8ssandra-operator`             |
| `k8ssandra-operator.nameOverride`                            | The name of the k8ssandra-operator deployment                                                                                                                                                   | `k8ssandra-operator`             |
| `k8ssandra-operator.clusterScope`                            | Whether to install the k8ssandra-operator in cluster scope                                                                                                                                      | `false`                          |
| `k8ssandra.reaper.cassandraUserSecretRef`                    | The secret containing the Reaper user credentials, has to contain username and password                                                                                                         | `platform-source-reaper-user`    |
| `k8ssandra.reaper.uiUserSecretRef`                           | The secret containing the Reaper UI user credentials, has to contain username and password                                                                                                      | `platform-source-reaper-ui-user` |
| `k8ssandra.reaper.heapSize`                                  | The heap size for the Reaper                                                                                                                                                                    | `2Gi`                            |
| `k8ssandra.reaper.metadata`                                  | The metadata for the Reaper instance. See https://docs.k8ssandra.io/reference/crd/k8ssandra-operator-crds-latest/#k8ssandraclusterspecreapermetadata                                            |                                  |
| `k8ssandra.reaper.telemetry`                                 | The telemetry for the Reaper instance. See https://docs.k8ssandra.io/reference/crd/k8ssandra-operator-crds-latest/#k8ssandraclusterspecreapertelemetry                                          |                                  |
| `k8ssandra.reaper.tolerations`                               | The tolerations for the Reaper instance. See https://docs.k8ssandra.io/reference/crd/k8ssandra-operator-crds-latest/#k8ssandraclusterspecreapertolerationsindex                                 |                                  |
| `k8ssandra.cassandra.config`                                 | The config for the Cassandra instance. See https://docs.k8ssandra.io/reference/crd/k8ssandra-operator-crds-latest/#k8ssandraclusterspeccassandraconfig                                          |                                  |
| `k8ssandra.cassandra.version`                                | The version of the Cassandra instance, supported versions are 3.xx, 4.xx, 5.xx                                                                                                                  | `5.0.2`                          |
| `k8ssandra.cassandra.superuserSecretRef`                     | The secret containing the superuser credentials, has to contain password                                                                                                                        | `platform-source-superuser`      |
| `k8ssandra.cassandra.metadata`                               | The metadata for the Cassandra instance. See https://docs.k8ssandra.io/reference/crd/k8ssandra-operator-crds-latest/#k8ssandraclusterspeccassandrametadata                                      |                                  |
| `k8ssandra.cassandra.telemetry`                              | The telemetry for the Cassandra instance. See https://docs.k8ssandra.io/reference/crd/k8ssandra-operator-crds-latest/#k8ssandraclusterspeccassandratelemetry                                    |                                  |
| `k8ssandra.cassandra.tolerations`                            | The tolerations for the Cassandra instance. See https://docs.k8ssandra.io/reference/crd/k8ssandra-operator-crds-latest/#k8ssandraclusterspeccassandratolerationsindex                           |                                  |
| `k8ssandra.cassandra.heapSize`                               | The heap size for the Cassandra instance, should be around 25% of request limits for memory                                                                                                     | `4Gi`                            |
| `k8ssandra.cassandra.storageSpec`                            | The storage spec for the Cassandra instance. See https://docs.k8ssandra.io/reference/crd/k8ssandra-operator-crds-latest/#k8ssandraclusterspeccassandrastorageconfigcassandradatavolumeclaimspec | `{}`                             |
| `k8ssandra.cassandra.storageSpec.accessModes`                | ] The access modes for the Cassandra instance                                                                                                                                                   | `""`                             |
| `k8ssandra.cassandra.storageSpec.resources.requests.storage` | The storage request for the Cassandra instance                                                                                                                                                  | `512Gi`                          |
| `k8ssandra.cassandra.resources.limits.cpu`                   | The CPU limit for the Cassandra instance                                                                                                                                                        | `8`                              |
| `k8ssandra.cassandra.resources.limits.memory`                | The memory limit for the Cassandra instance                                                                                                                                                     | `16Gi`                           |
| `k8ssandra.cassandra.resources.requests.cpu`                 | The CPU request for the Cassandra instance                                                                                                                                                      | `8`                              |
| `k8ssandra.cassandra.resources.requests.memory`              | The memory request for the Cassandra instance                                                                                                                                                   | `16Gi`                           |
| `k8ssandra.cassandra.datacenters`                            | The datacenters for the Cassandra instance.                                                                                                                                                     | `{}`                             |
| `k8ssandra.cassandra.datacenters.<datacenter-name>.stopped`  | Whether the datacenter is stopped or not                                                                                                                                                        | `false`                          |
| `k8ssandra.cassandra.datacenters.<datacenter-name>.size`     | The size of the datacenter                                                                                                                                                                      | `3`                              |
