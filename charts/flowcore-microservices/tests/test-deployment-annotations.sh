#!/usr/bin/env bash

set -euo pipefail

chart_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

rendered="$(helm template deployment-annotations-contract "$chart_dir" --values - <<'VALUES'
commonAnnotations:
  example.com/common: shared
deployments:
  api:
    enabled: true
    deployment:
      image: test-image
      tag: 1.0.0
      annotations:
        workloads.cast.ai/configuration: |
          vertical:
            optimization: on
            applyType: deferred
VALUES
)"

deployment_metadata="$(awk '
  /^kind: Deployment$/ { in_deployment = 1; next }
  in_deployment && /^metadata:/ { in_metadata = 1; next }
  in_metadata && /^spec:/ { exit }
  in_metadata { print }
' <<<"$rendered")"

grep -Fq 'example.com/common: shared' <<<"$deployment_metadata"
grep -Fq 'workloads.cast.ai/configuration: |' <<<"$deployment_metadata"
grep -Fq 'applyType: deferred' <<<"$deployment_metadata"

if [[ "$(grep -Fc 'workloads.cast.ai/configuration:' <<<"$rendered")" -ne 1 ]]; then
  printf 'deployment annotations must render exactly once on the Deployment resource\n' >&2
  exit 1
fi

printf 'flowcore-microservices deployment annotations contract passed\n'
