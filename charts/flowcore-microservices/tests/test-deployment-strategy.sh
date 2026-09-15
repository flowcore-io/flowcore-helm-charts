#!/usr/bin/env bash

set -euo pipefail

chart_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

render() {
  helm template strategy-contract "$chart_dir" \
    --set deployments.service.enabled=true \
    --set-string deployments.service.deployment.image=test-image \
    --set-string deployments.service.deployment.tag=1.0.0 \
    "$@"
}

rolling="$(render)"
grep -Fq 'type: RollingUpdate' <<<"$rolling"
grep -Fq 'rollingUpdate:' <<<"$rolling"

recreate="$(render --set-string deployments.service.deployment.strategy=Recreate)"
grep -Fq 'type: Recreate' <<<"$recreate"
if grep -Fq 'rollingUpdate:' <<<"$recreate"; then
  printf 'Recreate strategy must not render rollingUpdate settings\n' >&2
  exit 1
fi

printf 'flowcore-microservices deployment strategy contract passed\n'
