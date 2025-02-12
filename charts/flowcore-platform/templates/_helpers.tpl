{{/*
Expand the name of the chart.
*/}}
{{- define "apps.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apps.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "apps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "apps.labels" -}}
helm.sh/chart: {{ include "apps.chart" . }}
{{ include "apps.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "apps.selectorLabels" -}}
app.kubernetes.io/name: {{ include "apps.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "apps.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "apps.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate Redis HA Sentinel URL (read-write)
*/}}
{{- define "flowcore-platform.redisHaSentinelUrl" -}}
{{- $redisPassword := (lookup "v1" "Secret" .Release.Namespace (index .Values "valkey-ha").auth.existingSecret).data.password | b64dec -}}
{{- printf "redis+sentinel://:%s@%s-valkey-ha:26379/%s" $redisPassword .Release.Name (index .Values "valkey-ha").sentinel.primarySet -}}
{{- end -}}

{{/*
Generate Redis HA URL (read-only)
*/}}
{{- define "flowcore-platform.redisHaUrl" -}}
{{- $redisPassword := (lookup "v1" "Secret" .Release.Namespace (index .Values "valkey-ha").auth.existingSecret).data.password | b64dec -}}
{{- printf "redis://:%s@%s-valkey-ha:6379" $redisPassword .Release.Name -}}
{{- end -}}

{{/*
Generate Redis Single URL
*/}}
{{- define "flowcore-platform.redisSingleUrl" -}}
{{- $redisPassword := (lookup "v1" "Secret" .Release.Namespace (index .Values "valkey-single").auth.existingSecret).data.password | b64dec -}}
{{- printf "redis://:%s@%s-valkey-single:6379" $redisPassword .Release.Name -}}
{{- end -}}
