{{- define "dark-makers-org.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "dark-makers-org.fullname" -}}
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

{{- define "dark-makers-org.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "dark-makers-org.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "dark-makers-org.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dark-makers-org.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "dark-makers-org.dbHost" -}}
{{ include "dark-makers-org.fullname" . }}-db
{{- end }}

{{- define "dark-makers-org.databaseUrl" -}}
postgresql://{{ .Values.db.user }}:{{ .Values.db.password }}@{{ include "dark-makers-org.dbHost" . }}:5432/{{ .Values.db.name }}
{{- end }}
