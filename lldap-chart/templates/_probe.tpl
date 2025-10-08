{{- define "common.probe" -}}
{{- $probe := .probe -}}
{{- if $probe.enabled }}
{{ .name }}:
  {{- if $probe.exec }}
  exec:
    {{- toYaml $probe.exec | nindent 4 }}
  {{- else if $probe.httpGet }}
  httpGet:
    {{- toYaml $probe.httpGet | nindent 4 }}
  {{- else if $probe.tcpSocket }}
  tcpSocket:
    {{- toYaml $probe.tcpSocket | nindent 4 }}
  {{- end }}
  {{- range $k, $v := dict "initialDelaySeconds" $probe.initialDelaySeconds "periodSeconds" $probe.periodSeconds "timeoutSeconds" $probe.timeoutSeconds "successThreshold" $probe.successThreshold "failureThreshold" $probe.failureThreshold }}
  {{- if $v }}
  {{ $k }}: {{ $v }}
  {{- end }}
  {{- end }}
{{- end }}
{{- end }}
