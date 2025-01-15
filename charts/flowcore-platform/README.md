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

| Name                                  | Description                                                | Value                |
| ------------------------------------- | ---------------------------------------------------------- | -------------------- |
| `k8ssandra-operator.fullnameOverride` | The full name of the k8ssandra-operator deployment         | `k8ssandra-operator` |
| `k8ssandra-operator.nameOverride`     | The name of the k8ssandra-operator deployment              | `k8ssandra-operator` |
| `k8ssandra-operator.clusterScope`     | Whether to install the k8ssandra-operator in cluster scope | `false`              |
