#!/usr/bin/env bash

set -euo pipefail

chart_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
valid_digest="sha256:1111111111111111111111111111111111111111111111111111111111111111"

rendered="$({
  helm template image-digest-contract "$chart_dir" \
    --set-string imageRepository=registry.example.test \
    --set deployments.digestPinned.enabled=true \
    --set-string deployments.digestPinned.deployment.image=digest-image \
    --set-string deployments.digestPinned.deployment.tag=1.2.3 \
    --set-string deployments.digestPinned.deployment.digest="$valid_digest" \
    --set deployments.tagOnly.enabled=true \
    --set-string deployments.tagOnly.deployment.image=tag-image \
    --set-string deployments.tagOnly.deployment.tag=4.5.6
})"

assert_contains() {
  local expected="$1"
  if ! grep -Fq -- "$expected" <<<"$rendered"; then
    printf 'Expected rendered chart to contain: %s\n' "$expected" >&2
    exit 1
  fi
}

assert_contains 'app.kubernetes.io/version: "1.2.3"'
assert_contains "image: \"registry.example.test/digest-image@${valid_digest}\""
assert_contains 'app.kubernetes.io/version: "4.5.6"'
assert_contains 'image: "registry.example.test/tag-image:4.5.6"'

for invalid_digest in \
  "sha512:1111111111111111111111111111111111111111111111111111111111111111" \
  "sha256:not-a-digest"
do
  if failure="$({
    helm template image-digest-contract "$chart_dir" \
      --set deployments.invalid.enabled=true \
      --set-string deployments.invalid.deployment.image=invalid-image \
      --set-string deployments.invalid.deployment.tag=1.0.0 \
      --set-string deployments.invalid.deployment.digest="$invalid_digest"
  } 2>&1)"; then
    printf 'Expected Helm rendering to reject digest: %s\n' "$invalid_digest" >&2
    exit 1
  fi
  if ! grep -Fq 'deployment.digest must match sha256:<64 lowercase hexadecimal characters>' <<<"$failure"; then
    printf 'Expected a useful digest validation error, got:\n%s\n' "$failure" >&2
    exit 1
  fi
done

printf 'flowcore-microservices image digest contract passed\n'
