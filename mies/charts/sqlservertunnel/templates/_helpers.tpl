{{/*
Expand the name of the chart.
*/}}
{{- define "miesportal.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "miesportal.fullname" -}}
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
{{- define "miesportal.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "miesportal.labels" -}}
helm.sh/chart: {{ include "miesportal.chart" . }}
{{ include "miesportal.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "miesportal.selectorLabels" -}}
app.kubernetes.io/name: {{ include "miesportal.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "miesportal.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "miesportal.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Full resource names
*/}}

{{- define "miesportal.meshgatewayFullName" -}}
{{ .Values.mesh }}-{{ include "miesportal.fullname" . }}
{{- end }}

{{- define "miesportal.sqlserverFullName" -}}
sqlserver-{{ .Values.miesportal.release }}-miesportal
{{- end }}

{{- define "tunnel.name" -}}
sqlservertunnel-{{ .Release.Name }}-{{ .Release.Namespace }}-sqlserver-{{ .Values.miesportal.release }}
{{- end }}