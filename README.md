# KubeInFlight: Monitor Air Traffic with SDRs and k8s

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dump1090exporter.enabled | bool | `true` |  |
| dump1090exporter.image.pullPolicy | string | `"Always"` |  |
| dump1090exporter.image.repository | string | `"clawsicus/dump1090exporter"` |  |
| dump1090exporter.image.tag | string | `"latest"` |  |
| feeder_id | string | `"asdf"` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"kubeinflight.dev"` |  |
| ingress.hosts[0].paths | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| lat | string | `"36.7134572"` |  |
| long | string | `"-76.2757609"` |  |
| nameOverride | string | `""` |  |
| namespace | string | `"flightaware"` |  |
| piaware.image.pullPolicy | string | `"IfNotPresent"` |  |
| piaware.image.repository | string | `"mikenye/piaware"` |  |
| piaware.image.tag | string | `"latest"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| receiver_type | string | `"rtlsdr"` |  |
| replicaCount | int | `1` |  |
| securityContext | object | `{}` |  |
| tz | string | `"America/New_York"` |  |
