{{/*
Expand the name of the chart.
*/}}
{{- define "blobby-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "blobby-server.fullname" -}}
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
{{- define "blobby-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "blobby-server.labels" -}}
helm.sh/chart: {{ include "blobby-server.chart" . }}
{{ include "blobby-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "blobby-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "blobby-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "blobby-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "blobby-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Render a list of env entries. Each entry has a value or a secretKeyRef.
*/}}
{{- define "blobby-server.env" -}}
{{- range . }}
- name: {{ .name }}
  {{- if .secretKeyRef }}
  valueFrom:
    secretKeyRef:
      key: {{ .secretKeyRef.key }}
      name: {{ .secretKeyRef.name }}
  {{- else if hasKey . "value" }}
  value: {{ .value | quote }}
  {{- else }}
  {{- fail (printf "env entry %s has neither value nor secretKeyRef" .name) }}
  {{- end }}
{{- end }}
{{- end }}
