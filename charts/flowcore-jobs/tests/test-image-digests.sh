#!/usr/bin/env bash
set -euo pipefail

chart_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
digest="sha256:1111111111111111111111111111111111111111111111111111111111111111"
tag="candidate-efbdcf1d413a0ebbdbb2f559014eff0e18fa576b"
args=(image-digest-contract "$chart_dir"
  --set-string imageRepository=registry.example.test
  --set cronjobs.pinned.enabled=true
  --set-string cronjobs.pinned.job.image=job-image
  --set-string "cronjobs.pinned.job.tag=$tag"
  --set cronjobs.legacy.enabled=true
  --set-string cronjobs.legacy.job.image=legacy-image
  --set-string cronjobs.legacy.job.tag=1.2.3)

without_digest=$(helm template "${args[@]}")
empty_digest=$(helm template "${args[@]}" --set-string cronjobs.pinned.job.digest=)
[[ "$without_digest" == "$empty_digest" ]] || { echo 'An empty digest changed legacy rendering' >&2; exit 1; }
grep -Fq "image: \"registry.example.test/job-image:$tag\"" <<<"$without_digest"

rendered=$(helm template "${args[@]}" --set-string "cronjobs.pinned.job.digest=$digest")
grep -Fq "image: \"registry.example.test/job-image@$digest\"" <<<"$rendered"
grep -Fq 'image: "registry.example.test/legacy-image:1.2.3"' <<<"$rendered"
grep -Fq "app.kubernetes.io/version: \"$tag\"" <<<"$rendered"
grep -Fq 'app.kubernetes.io/version: "1.2.3"' <<<"$rendered"
# Pod labels reuse the root labels through a YAML anchor. Digest text must never
# enter the shared version labels: Kubernetes rejects '@', ':', and >63 bytes.
while IFS= read -r label; do
  [[ ${#label} -le 63 && "$label" =~ ^[A-Za-z0-9]([-A-Za-z0-9_.]*[A-Za-z0-9])?$ ]] || {
    echo "Invalid rendered version label: $label" >&2; exit 1;
  }
done < <(sed -n 's/.*app.kubernetes.io\/version: "\(.*\)"/\1/p' <<<"$rendered")

for invalid in sha512:1111111111111111111111111111111111111111111111111111111111111111 sha256:not-a-digest sha256:ABCDEF sha256:111111111111111111111111111111111111111111111111111111111111111; do
  if failure=$(helm template "${args[@]}" --set-string "cronjobs.pinned.job.digest=$invalid" 2>&1); then
    echo "Expected digest rejection: $invalid" >&2; exit 1
  fi
  grep -Fq 'job.digest must match sha256:<64 lowercase hexadecimal characters> for pinned' <<<"$failure"
done
echo 'flowcore-jobs image digest contract passed'
