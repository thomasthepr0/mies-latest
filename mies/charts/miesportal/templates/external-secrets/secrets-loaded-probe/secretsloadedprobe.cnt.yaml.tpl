{{- define "miesportal.secretsloadedprobeContainer" -}}
- name: secretsloadedprobe
  image: busybox
  command: ["sh", "-c", "/usr/local/bin/checkSecret.sh"]
  volumeMounts:
    - name: secretsloadedprobe
      subPath: "checkSecret.sh"
      mountPath: "/usr/local/bin/checkSecret.sh"
    - name: externalsecrets
      mountPath: /externalsecrets
      readOnly: true
{{- end -}}
