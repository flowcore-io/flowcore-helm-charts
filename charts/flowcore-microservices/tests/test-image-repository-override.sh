#!/usr/bin/env bash

set -euo pipefail

chart_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

rendered="$({
  helm template image-repository-contract "$chart_dir" \
    --set-string imageRepository=registry.example.test \
    --set deployments.globalRepo.enabled=true \
    --set-string deployments.globalRepo.deployment.image=global-image \
    --set-string deployments.globalRepo.deployment.tag=1.0.0 \
    --set deployments.overriddenRepo.enabled=true \
    --set-string deployments.overriddenRepo.deployment.repository=ghcr.io/flowcore-io \
    --set-string deployments.overriddenRepo.deployment.image=override-image \
    --set-string deployments.overriddenRepo.deployment.tag=2.0.0 \
    --set deployments.overriddenRepo.sidecars.helper.enabled=true \
    --set-string deployments.overriddenRepo.sidecars.helper.image=helper-image \
    --set-string deployments.overriddenRepo.sidecars.helper.tag=3.0.0
})"

assert_contains() {
  local expected="$1"
  if ! grep -Fq -- "$expected" <<<"$rendered"; then
    printf 'Expected rendered chart to contain: %s\n' "$expected" >&2
    exit 1
  fi
}

# A deployment without an override keeps the chart-level repository.
assert_contains 'image: "registry.example.test/global-image:1.0.0"'

# Only the overriding deployment moves to the other registry.
assert_contains 'image: "ghcr.io/flowcore-io/override-image:2.0.0"'

# A sidecar without its own repo inherits the repository of its deployment.
assert_contains 'image: "ghcr.io/flowcore-io/helper-image:3.0.0"'

printf 'flowcore-microservices image repository override contract passed\n'
