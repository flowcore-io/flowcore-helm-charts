# Flowcore Microservices

An opinionated Helm chart for deploying microservices to Kubernetes.

## Installing the Chart

To add the chart repository to Helm:

```bash
helm repo add flowcore https://flowcore-io.github.io/flowcore-helm-charts/
```

create a `values.yaml` file and fill in the deployments section. then run:

```bash
helm install my-release flowcore/flowcore-microservices -f values.yaml
```

## Parameters

### Global

| Name               | Description                                                        | Value                                          |
| ------------------ | ------------------------------------------------------------------ | ---------------------------------------------- |
| `environment`      | Environment name                                                   | `flowcore`                                     |
| `platform`         | Platform that these microservices are part of                      | `flowcore`                                     |
| `imageRepository`  | The image repository to use for all microservices in this chart    | `305363105399.dkr.ecr.eu-west-1.amazonaws.com` |
| `oidcWellKnownUrl` | The OIDC well known URL to use for all microservices in this chart |                                                |


### Domain Settings

| Name               | Description                                              | Value |
| ------------------ | -------------------------------------------------------- | ----- |
| `transport`        | Ingress settings for the transport domain                | `{}`  |
| `transport.<name>` | Environment variables for the transport in object format |       |


### Deployments

| Name                                                                        | Description                                                                                        | Value |
| --------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | ----- |
| `deployments`                                                               | List of microservices to deploy                                                                    | `{}`  |
| `deployments.<microservice>`                                                | Configuration entry for a microservice                                                             |       |
| `deployments.<microservice>.enabled`                                        | Whether to deploy this microservice [boolean]                                                      |       |
| `deployments.<microservice>.component`                                      | What type of microservice this is [api, adapter, ...]                                              |       |
| `deployments.<microservice>.source`                                         | What type of source this microservice uses [node, go, rust, ...]                                   |       |
| `deployments.<microservice>.deployment`                                     | Configuration for the deployment                                                                   |       |
| `deployments.<microservice>.deployment.image`                               | The image name to use for this microservice, excluding the repository [string]                     |       |
| `deployments.<microservice>.deployment.tag`                                 | The image tag to use for this microservice [string]                                                |       |
| `deployments.<microservice>.deployment.replicas`                            | The number of replicas to deploy [integer]                                                         |       |
| `deployments.<microservice>.service`                                        | Service configuration for this microservice if needed                                              |       |
| `deployments.<microservice>.service.enabled`                                | Whether to deploy a service for this microservice [boolean]                                        |       |
| `deployments.<microservice>.service.httpPort`                               | The http port to expose for this microservice [integer]                                            |       |
| `deployments.<microservice>.service.extraPorts`                             | Extra ports to expose for this microservice                                                        |       |
| `deployments.<microservice>.service.extraPorts.<name>`                      | Configuration for an extra port to expose                                                          |       |
| `deployments.<microservice>.service.extraPorts.<name>.port`                 | The port to expose [integer]                                                                       |       |
| `deployments.<microservice>.service.extraPorts.<name>.type`                 | The type of port to expose [TCP, UDP, ...]                                                         |       |
| `deployments.<microservice>.ingress`                                        | Ingress configuration for this microservice if needed                                              |       |
| `deployments.<microservice>.ingress.enabled`                                | Whether to deploy an ingress for this microservice [boolean]                                       |       |
| `deployments.<microservice>.ingress.host`                                   | The host to use for this microservice [string]                                                     |       |
| `deployments.<microservice>.ingress.tlsSecret`                              | The tls secret to use for this microservice [string]                                               |       |
| `deployments.<microservice>.env`                                            | Environment variables to set for this microservice                                                 |       |
| `deployments.<microservice>.env.<variable>`                                 | Configuration for an environment variable                                                          |       |
| `deployments.<microservice>.env.<variable>.value`                           | The value to set for this environment variable, use valueFrom if you want to use a secret [string] |       |
| `deployments.<microservice>.useTransport`                                   | Array or Object of transport services to use for this microservice                                 |       |
| `deployments.<microservice>.useTransport.<name>`                            | The name of the transport service to use                                                           |       |
| `deployments.<microservice>.useTransport.<name>.overrides`                  | Overrides for the transport service                                                                |       |
| `deployments.<microservice>.useTransport.<name>.overrides.<variable>`       | Configuration for an environment variable                                                          |       |
| `deployments.<microservice>.useTransport.<name>.overrides.<variable>.value` | The value to set for this environment variable, use valueFrom if you want to use a secret [string] |       |

