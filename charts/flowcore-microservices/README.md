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

| Name               | Description                                                           | Value                                           |
| ------------------ | --------------------------------------------------------------------- | ----------------------------------------------- |
| `environment`      | Environment name                                                      | `flowcore`                                      |
| `platform`         | Platform that these microservices are part of                         | `flowcore`                                      |
| `imageRepository`  | The image repository to use for all microservices in this chart       | `305363105399.dkr.ecr.eu-west-1.amazonaws.com`  |
| `oidcWellKnownUrl` | The OIDC well known URL to use for all microservices in this chart    | `https://auth.someurl.com/.wellknown/something` |
| `imagePullSecrets` | List of image pull secrets to use for all microservices in this chart | `[]`                                            |
| `webhookBaseURL`   | The base URL to use for flowcore webhooks                             | `https://webhook.api.staging.flowcore.io`       |

### Domain Settings

| Name                | Description                                              | Value |
| ------------------- | -------------------------------------------------------- | ----- |
| `transport`         | Ingress settings for the transport domain                | `{}`  |
| `transport.<name>`  | Environment variables for the transport in object format |       |
| `commonAnnotations` | Annotations to set for all resources in the chart        | `{}`  |

### Deployments

| Name                                                                        | Description                                                                                        | Value |
| --------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | ----- |
| `deployments`                                                               | List of microservices to deploy                                                                    | `{}`  |
| `deployments.<microservice>`                                                | Configuration entry for a microservice                                                             |       |
| `deployments.<microservice>.enabled`                                        | Whether to deploy this microservice [boolean]                                                      |       |
| `deployments.<microservice>.podAnnotations`                                 | Annotations to set for the pod                                                                     |       |
| `deployments.<microservice>.component`                                      | What type of microservice this is [api, adapter, ...]                                              |       |
| `deployments.<microservice>.restartPolicy`                                  | The restart policy to use for this microservice, defaults to Always [Always, OnFailure, Never]     |       |
| `deployments.<microservice>.imagePullSecrets`                               | List of image pull secrets to use for this microservice [array]                                    |       |
| `deployments.<microservice>.source`                                         | What type of source this microservice uses [node, go, rust, ...]                                   |       |
| `deployments.<microservice>.metrics:`                                       | Whether to deploy metrics for this microservice                                                    |       |
| `deployments.<microservice>.metrics.enabled`                                | Whether to deploy metrics for this microservice [boolean]                                          |       |
| `deployments.<microservice>.metrics.port`                                   | The optional port to expose for metrics [integer]                                                  |       |
| `deployments.<microservice>.metrics.path`                                   | The optional path to expose for metrics [string]                                                   |       |
| `deployments.<microservice>.deployment`                                     | Configuration for the deployment                                                                   |       |
| `deployments.<microservice>.deployment.maxSurge`                            | The maximum number of pods that can be scheduled above the desired number of pods [integer]        |       |
| `deployments.<microservice>.deployment.maxUnavailable`                      | The maximum number of pods that can be unavailable during the update process [integer]             |       |
| `deployments.<microservice>.deployment.image`                               | The image name to use for this microservice, excluding the repository [string]                     |       |
| `deployments.<microservice>.deployment.tag`                                 | The image tag to use for this microservice [string]                                                |       |
| `deployments.<microservice>.deployment.replicas`                            | The number of replicas to deploy [integer]                                                         |       |
| `deployments.<microservice>.deployment.resources`                           | Resource configuration for this microservice                                                       |       |
| `deployments.<microservice>.deployment.serviceAccount`                      | The service account to use for this microservice [string]                                          |       |
| `deployments.<microservice>.service`                                        | Service configuration for this microservice if needed                                              |       |
| `deployments.<microservice>.service.enabled`                                | Whether to deploy a service for this microservice [boolean]                                        |       |
| `deployments.<microservice>.service.httpPort`                               | The http port to expose for this microservice [integer]                                            |       |
| `deployments.<microservice>.service.extraPorts`                             | Extra ports to expose for this microservice                                                        |       |
| `deployments.<microservice>.service.extraPorts.<name>`                      | Configuration for an extra port to expose                                                          |       |
| `deployments.<microservice>.service.extraPorts.<name>.port`                 | The port to expose [integer]                                                                       |       |
| `deployments.<microservice>.service.extraPorts.<name>.type`                 | The type of port to expose [TCP, UDP, ...]                                                         |       |
| `deployments.<microservice>.ingress`                                        | List of Ingress configurations for this microservice if needed [array]                             |       |
| `deployments.<microservice>.ingress.enabled`                                | Whether to deploy an Ingress for this microservice [boolean]                                       |       |
| `deployments.<microservice>.ingress.annotations`                            | Annotations to set for this Ingress                                                                |       |
| `deployments.<microservice>.ingress.route`                                  | The route to use for this microservice [host, tlsSecret]                                           |       |
| `deployments.<microservice>.ingress.hosts`                                  | The hosts to use for this microservice, list of strings [array]                                    |       |
| `deployments.<microservice>.ingress.tlsSecret`                              | The tls secret to use for this microservice [string]                                               |       |
| `deployments.<microservice>.env`                                            | Environment variables to set for this microservice                                                 |       |
| `deployments.<microservice>.env.<variable>`                                 | Configuration for an environment variable                                                          |       |
| `deployments.<microservice>.env.<variable>.value`                           | The value to set for this environment variable, use valueFrom if you want to use a secret [string] |       |
| `deployments.<microservice>.useTransport`                                   | Array or Object of transport services to use for this microservice                                 |       |
| `deployments.<microservice>.useTransport.<name>`                            | The name of the transport service to use                                                           |       |
| `deployments.<microservice>.useTransport.<name>.overrides`                  | Overrides for the transport service                                                                |       |
| `deployments.<microservice>.useTransport.<name>.overrides.<variable>`       | Configuration for an environment variable                                                          |       |
| `deployments.<microservice>.useTransport.<name>.overrides.<variable>.value` | The value to set for this environment variable, use valueFrom if you want to use a secret [string] |       |
| `deployments.<microservice>.useFlowcoreWebhooks`                            | Whether to use flowcore webhooks for this microservice [boolean]                                   |       |
| `deployments.<microservice>.sidecars`                                       | list of sidecars to deploy                                                                         |       |
| `deployments.<microservice>.sidecars.<name>`                                | Configuration for a sidecar                                                                        |       |
| `deployments.<microservice>.sidecars.<name>.enabled`                        | Whether to deploy this sidecar [boolean]                                                           |       |
| `deployments.<microservice>.sidecars.<name>.repo`                           | The image repository to use for this sidecar, optional [string]                                    |       |
| `deployments.<microservice>.sidecars.<name>.image`                          | The image name to use for this sidecar, excluding the repository [string]                          |       |
| `deployments.<microservice>.sidecars.<name>.tag`                            | The image tag to use for this sidecar [string]                                                     |       |
| `deployments.<microservice>.sidecars.<name>.env`                            | Environment variables to set for this sidecar                                                      |       |
| `deployments.<microservice>.sidecars.<name>.env.<variable>`                 | Configuration for an environment variable                                                          |       |
| `deployments.<microservice>.sidecars.<name>.env.<variable>.value`           | The value to set for this environment variable, use valueFrom if you want to use a secret [string] |       |
| `deployments.<microservice>.sidecars.<name>.httpPort`                       | The http port for this sidecar, used for health checks [integer]                                   |       |
| `deployments.<microservice>.sidecars.<name>.resources`                      | Resource configuration for this sidecar                                                            |       |
| `deployments.<microservice>.sidecars.<name>.volumes`                        | List of volumes to mount for this sidecar, optional [array] that points to the volumes section     |       |
| `deployments.<microservice>.volumes`                                        | list of config volumes to deploy                                                                   |       |
| `deployments.<microservice>.volumes.<name>`                                 | Configuration for a volume                                                                         |       |
| `deployments.<microservice>.volumes.<name>.config`                          | Config Map to use for this volume                                                                  |       |
| `deployments.<microservice>.volumes.<name>.secret`                          | Secret to use for this volume                                                                      |       |
| `deployments.<microservice>.volumes.<name>.mountPath`                       | The mount path to use for this volume                                                              |       |
| `deployments.<microservice>.volumes.<name>.subPath`                         | The sub path to use for this volume, optional                                                      |       |
| `deployments.<microservice>.volumes.<name>.mainMount`                       | Whether this volume is mounted to the main container, optional [yes, no] defaults to yes           |       |
| `deployments.<microservice>.volumes.<name>.type`                            | The type of volume to use [configMap, secret, emptyDir]                                            |       |
| `deployments.<microservice>.affinity`                                       | Affinity configuration for this microservice                                                       |       |
| `deployments.<microservice>.livenessProbe`                                  | Liveness probe configuration for this microservice                                                 |       |
| `deployments.<microservice>.readinessProbe`                                 | Readiness probe configuration for this microservice                                                |       |
| `deployments.<microservice>.castAiSpot`                                     | Configure service for spot instance prefer or required                                             |       |
| `deployments.<microservice>.castAiNodeTemplate`                             | Cast AI node template values [string array]                                                        |       |
| `deployments.<microservice>.hpa`                                            | Horizontal Pod Autoscaler configuration for this microservice                                      |       |
| `deployments.<microservice>.hpa.enabled`                                    | Whether to deploy a Horizontal Pod Autoscaler for this microservice [boolean]                      |       |
| `deployments.<microservice>.hpa.minReplicas`                                | The minimum number of replicas to deploy for this microservice [integer]                           |       |
| `deployments.<microservice>.hpa.maxReplicas`                                | The maximum number of replicas to deploy for this microservice [integer]                           |       |
| `deployments.<microservice>.hpa.cpu`                                        | The CPU threshold for the Horizontal Pod Autoscaler [integer]                                      |       |
| `deployments.<microservice>.hpa.memory`                                     | The memory threshold for the Horizontal Pod Autoscaler [integer]                                   |       |

