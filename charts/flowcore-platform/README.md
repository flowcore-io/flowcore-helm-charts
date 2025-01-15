# Flowcore Platform

An Helm chart for installing a dedicated instance of the Flowcore Platform

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

### Platform configuration

| Name                                 | Description                                                                                            | Value |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------ | ----- |
| `requests`                           | List of secrets to request                                                                             | `{}`  |
| `requests.<secret>`                  | Configuration of a secret request [object]                                                             |       |
| `requests.<secret>.enabled`          | Whether to request this secret [boolean]                                                               |       |
| `requests.<secret>.source`           | The source secret to copy from [object]                                                                |       |
| `requests.<secret>.source.name`      | The name of the source secret [string]                                                                 |       |
| `requests.<secret>.source.namespace` | The namespace of the source secret [string]                                                            |       |
| `requests.<secret>.destination`      | The destination secret to copy to [object]                                                             |       |
| `requests.<secret>.destination`      | The name of the destination secret [string] if not set, the name of the request will be used           |       |
| `requests.<secret>.destination`      | The namespace of the destination secret [string] if not set, the namespace of the release will be used |       |
