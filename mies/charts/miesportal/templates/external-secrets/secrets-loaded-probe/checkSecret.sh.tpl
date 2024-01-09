{{- define "miesportal.checkSecret.sh" -}}
#!/bin/sh

while [ -z "$(ls -A /externalsecrets/ 2>/dev/null)" ]; do
  echo "Waiting for secret to be available..."
  sleep 1
done

echo "Secrets loaded"
{{- end }}