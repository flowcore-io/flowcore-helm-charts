# Flowcore Secret Request Controller

The Flowcore Secret Request Controller is a Helm chart that allows you to request secrets from other namespaces and copy them to the namespace of the release.

## Prerequisites

- [metacontroller](https://metacontroller.github.io/metacontroller/intro.html)

## Installing the Chart

To add the chart repository to Helm:

```bash
helm repo add flowcore https://flowcore-io.github.io/flowcore-helm-charts/
```

create a `values.yaml` file and fill in the deployments section. then run:

```bash
helm install my-release flowcore/flowcore-secret-requester -f values.yaml
```

> **Note**: If you want to install the chart without the metacontroller helm chart, you can set `metacontroller-helm.enabled` to `false`.

## Parameters

### Controller configuration

| Name                        | Description                                                                                                                                                     | Value                                  |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| `controllerImage`           | The image of the secret request controller                                                                                                                      | `flowcoreio/secret-request-controller` |
| `controllerTag`             | The tag of the secret request controller                                                                                                                        | `1.0.5`                                |
| `replicaCount`              | Number of replicas for the secret request controller                                                                                                            | `1`                                    |
| `resources`                 | Resource requests and limits for the secret request controller see https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ for more info | `{}`                                   |
| `resources.requests`        | Resource requests for the secret request controller                                                                                                             | `{}`                                   |
| `resources.requests.cpu`    | The amount of CPU to request for the secret request controller                                                                                                  | `65m`                                  |
| `resources.requests.memory` | The amount of memory to request for the secret request controller                                                                                               | `122Mi`                                |
| `resources.limits`          | Resource limits for the secret request controller                                                                                                               | `{}`                                   |
| `resources.limits.cpu`      | The amount of CPU to limit for the secret request controller                                                                                                    | `120m`                                 |
| `resources.limits.memory`   | The amount of memory to limit for the secret request controller                                                                                                 | `148Mi`                                |
| `service`                   | Configuration for the service                                                                                                                                   | `{}`                                   |
| `service.port`              | The port the service listens on                                                                                                                                 | `3000`                                 |
| `namespace`                 | The namespace to deploy the secret request controller in                                                                                                        |                                        |

### Metacontroller

| Name                              | Description                                                                                                | Value  |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------ |
| `metacontroller-helm`             | see https://metacontroller.github.io/metacontroller/guide/helm-install.html for more configuration options | `{}`   |
| `metacontroller-helm.enabled`     | Enable the metacontroller helm chart                                                                       | `true` |
| `metacontroller-helm.replicas`    | Number of replicas for the metacontroller deployment                                                       | `2`    |
| `metacontroller-helm.commandArgs` | Command arguments for the metacontroller deployment                                                        | `[]`   |
