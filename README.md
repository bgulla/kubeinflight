# KubeInFlight: Monitor Air Traffic with SDRs and k8s

![FlightAware](/static/flightaware.png?raw=true)

## Prerequisites
* [RTL2832U Software Defined Radio](https://www.amazon.com/RTL-SDR-Blog-RTL2832U-Software-Defined/dp/B0129EBDS2/ref=sr_1_3?keywords=rtl+sdr&qid=1636478210&qsid=133-2081778-9779013&sr=8-3&sres=B0129EBDS2%2CB01GDN1T4S%2CB008S7AVTC%2CB07WGWZS1D%2CB01HA642SW%2CB01B4L48QU%2CB06Y1GN5RP%2CB06Y1FDDBF%2CB079C4S2BT%2CB0132MB8LM%2CB07W6VFWGS%2CB0132N1DM0%2CB06Y1D7P48%2CB073JZ8CC2%2CB07W3XQKXV%2CB009U7WZCA)
* A Kubernetes Cluster (we like [k3s](https://k3s.io).)
* *[Optional]* A [FlightAware](https://flightaware.com) account / API-Key
* [Latitude and Longitude for your location](https://www.latlong.net/_)

[Flightaware Build Instructions](https://flightaware.com/adsb/piaware/build/)

## Installation Instructions
```bash
# Add the kubeinflight helm chart repo
helm repo add kubeinflight https://bgulla.github.io/kubeinflight
helm repo update

# Install the helm chart
helm install kubeinflight kubeinflight/kubeinflight  \
  -n flightaware \
  --create-namespace

## Note: kubeinflight will only run on nodes that are labeled as having an SDR attached. Do the following:
kubectl label node <node_with_usb_sdr> sdr=true
```

## Prometheus/`dump1090exporter`
![Grafana](/static/grafana.png?raw=true)
```bash
scrape_configs:
  - job_name: 'dump1090'
    scrape_interval: 10s
    scrape_timeout: 5s
    static_configs:
      - targets: ['<nodeport_ip>:30669']
```
Note: Currently you need to BYO grafana/prometheus, I will be adding internal deployment of these pods soon-ish.

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
