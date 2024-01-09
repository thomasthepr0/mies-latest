{{- define "miesportal.appsettings.production.json" -}}
{{- $portalConnection := printf "%s_%s_svc_1433.mesh,80;User Id=sa;Password=0Kupator;Database=NECMSSDB;TrustServerCertificate=True" (include "miesportal.sqlserverFullName" .) .Release.Namespace -}}
{{- $portalConnectionString := printf "Server=%s" $portalConnection -}}
{{- $webApiKumaServiceName := printf "%s_%s_svc_44367.mesh" (include "miesportal.webserviceFullName" .) .Release.Namespace -}}
{{- $webApiAddress := printf "http://%s/api/" $webApiKumaServiceName -}}
{
  "Jwt": {{ .Values.appsettings.Jwt | toJson  }},
  "Logging": {{ .Values.appsettings.Logging | toJson  }},
  "AllowedHosts": {{ .Values.appsettings.AllowedHosts | toJson  }},
  "Settings": {"WebApiBaseUrl": "{{ $webApiAddress }}"},
  "remedyWebService": {{ .Values.appsettings.remedyWebService | toJson  }},
  "runtimeOptions": {
    "configProperties": {
      "System.Net.Http.UseSocketsHttpHandler": false
    }
  },
  "smtp": {{ .Values.appsettings.smtp | toJson  }},
  "session": {{ .Values.appsettings.session | toJson  }},
  "AppInfo": {{ .Values.appsettings.AppInfo | toJson  }},
  "2FA": {{ index .Values.appsettings "2FA" | toJson  }},
  "OIDC": {{ .Values.appsettings.OIDC | toJson  }}
}
{{- end }}