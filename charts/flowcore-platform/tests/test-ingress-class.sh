#!/usr/bin/env bash

set -euo pipefail

chart_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 1. Default backwards-compatible rendering: legacy annotation + per-service annotations, no spec.ingressClassName
default_rendered="$(helm template platform-default "$chart_dir" --show-only templates/ingresses.yaml)"

if [[ "$(grep -Fc 'kubernetes.io/ingress.class: nginx' <<<"$default_rendered")" -ne 4 ]]; then
  printf 'expected 4 legacy kubernetes.io/ingress.class annotations by default\n' >&2
  exit 1
fi

if grep -Fq 'ingressClassName:' <<<"$default_rendered"; then
  printf 'default rendering must not emit spec.ingressClassName\n' >&2
  exit 1
fi

if [[ "$(grep -Fc 'nginx.ingress.kubernetes.io/proxy-connect-timeout: "255"' <<<"$default_rendered")" -ne 4 ]]; then
  printf 'expected 4 default per-service proxy-connect-timeout annotations\n' >&2
  exit 1
fi

# 2. Custom ingressClassName + disabled legacy per-service annotations (F5 side-by-side mode)
f5_rendered="$(helm template platform-f5 "$chart_dir" --show-only templates/ingresses.yaml --values - <<'VALUES'
commonAnnotations:
  example.com/managed-by: flowcore
flowcore:
  domain: fcm.globetracker.io
  tlsSecret: fcm-certificate-tls
  ingressClassName: nginx-f5
  includeIngressAnnotations: false
VALUES
)"

if [[ "$(grep -Fc 'ingressClassName: nginx-f5' <<<"$f5_rendered")" -ne 4 ]]; then
  printf 'expected 4 spec.ingressClassName: nginx-f5 entries\n' >&2
  exit 1
fi

if grep -Fq 'kubernetes.io/ingress.class:' <<<"$f5_rendered"; then
  printf 'custom ingressClassName must omit legacy kubernetes.io/ingress.class annotation\n' >&2
  exit 1
fi

if grep -Fq 'nginx.ingress.kubernetes.io/' <<<"$f5_rendered"; then
  printf 'includeIngressAnnotations=false must omit per-service community nginx annotations\n' >&2
  exit 1
fi

if [[ "$(grep -Fc 'example.com/managed-by: flowcore' <<<"$f5_rendered")" -ne 4 ]]; then
  printf 'commonAnnotations must still render on all 4 Ingresses when includeIngressAnnotations=false\n' >&2
  exit 1
fi

# 3. Custom ingressClassName + includeIngressAnnotations=false + no commonAnnotations: no empty annotations key
clean_rendered="$(helm template platform-clean "$chart_dir" --show-only templates/ingresses.yaml --values - <<'VALUES'
flowcore:
  ingressClassName: nginx-f5
  includeIngressAnnotations: false
VALUES
)"

if grep -Fq 'annotations:' <<<"$clean_rendered"; then
  printf 'must not emit empty annotations block when no annotations apply\n' >&2
  exit 1
fi

printf 'flowcore-platform ingressClassName contract passed\n'
