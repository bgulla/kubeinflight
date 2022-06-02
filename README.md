# KubeInFlight: Monitor Air Traffic with SDRs and k8s

![FlightAware](/static/flightaware.png?raw=true)

## Prerequisites
* [RTL2832U Software Defined Radio](https://www.amazon.com/RTL-SDR-Blog-RTL2832U-Software-Defined/dp/B0129EBDS2/ref=sr_1_3?keywords=rtl+sdr&qid=1636478210&qsid=133-2081778-9779013&sr=8-3&sres=B0129EBDS2%2CB01GDN1T4S%2CB008S7AVTC%2CB07WGWZS1D%2CB01HA642SW%2CB01B4L48QU%2CB06Y1GN5RP%2CB06Y1FDDBF%2CB079C4S2BT%2CB0132MB8LM%2CB07W6VFWGS%2CB0132N1DM0%2CB06Y1D7P48%2CB073JZ8CC2%2CB07W3XQKXV%2CB009U7WZCA)
* A Kubernetes Cluster (we like [k3s](https://k3s.io).)
* *[Optional]* A [FlightAware](https://flightaware.com) account / API-Key
* *[Optional]* A [FlightRadar24](https://flightradar24.com) account / sharing key
* [Latitude and Longitude for your location](https://www.latlong.net/_)

[Flightaware Build Instructions](https://flightaware.com/adsb/piaware/build/)

## Quick Start Installation Instructions
```bash
# Add the kubeinflight helm chart repo
helm repo add kubeinflight https://bgulla.github.io/kubeinflight
helm repo update

## Note: kubeinflight will only run on nodes that are labeled as having an SDR attached. Do the following:
kubectl label node <node_with_usb_sdr> sdr=true

# Install the helm chart
helm install kubeinflight kubeinflight/kubeinflight  \
  -n flightaware \
  --create-namespace
```

## Example Installation Instructions
Installing full suite for reporting to FlightAware and FlightRadar24 with example ingress enabled
```bash
helm install kubeinflight kubeinflight/kubeinflight \
  -n flightaware  --create-namespace --set replicaCount=1 \ 
  --set lat="##.##########" --set long='-##.###########' \ 
  --set ingress.enabled='true' --set 'ingress.hosts[0].host'='adbs.example.com' \
  --set fr24feed.enabled='true' --set fr24feed_key='YOURFR24KEY'
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
| dump1090exporter.image.pullPolicy | string | `"IfNotPresent"` |  |
| dump1090exporter.image.repository | string | `"clawsicus/dump1090exporter"` |  |
| dump1090exporter.image.tag | string | `"latest"` |  |
| dump1090exporter.nodeport.enable | bool | `true` |  |
| dump1090exporter.nodeport.port | int | `30070` |  |
| feeder_id | string | `nil` |  |
| fr24feed_key | string | `nil` |  |
| fr24feed.beasthost | string | `http-nodeport.flightaware.svc` |  |
| fr24feed.beastport | string | `30005` |  |
| fr24feed.enabled | bool | `false` |  |
| fr24feed.image.repository | string | `mikenye/fr24feed` |  | 
| fr24feed.image.pullPolicy | string | `IfNotPresent` |  |
| fr24feed.image.tag | string | `latest` |  |
| fr24feed.mlat | string | `yes` |  |
| fr24feed.nodeport.enable | bool | `false` |  |
| fr24feed.nodeport.port | int | `30072` |  |
| fullnameOverride | string | `""` |  |
| grafana.auth.anonymous.enabled | bool | `true` |  |
| grafana.auth.basic.enabled | bool | `true` |  |
| grafana.enabled | bool | `true` |  |
| grafana.image.pullPolicy | string | `"IfNotPresent"` |  |
| grafana.image.repository | string | `"grafana/grafana"` |  |
| grafana.image.tag | string | `"6.7.1-ubuntu"` |  |
| grafana.nodeport.enable | bool | `true` |  |
| grafana.nodeport.port | int | `30071` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"kubeinflight.dev"` |  |
| ingress.hosts[0].paths | list | `[]` |  |
| lat | string | `"36.7134572"` |  |
| long | string | `"-76.2757609"` |  |
| nameOverride | string | `""` |  |
| namespace | string | `"flightaware"` |  |
| piaware.image.pullPolicy | string | `"IfNotPresent"` |  |
| piaware.image.repository | string | `"mikenye/piaware"` |  |
| piaware.image.tag | string | `"v5.0_amd64"` |  |
| piaware.nodeport.enable | bool | `true` |  |
| piaware.nodeport.port | int | `30068` |  |
| prometheus.enableNodeport | bool | `true` |  |
| prometheus.enabled | bool | `true` |  |
| prometheus.image.pullPolicy | string | `"IfNotPresent"` |  |
| prometheus.image.repository | string | `"prom/prometheus"` |  |
| prometheus.image.tag | string | `"latest"` |  |
| prometheus.persistence.accessMode | string | `"ReadWriteMany"` |  |
| prometheus.persistence.enabled | bool | `true` |  |
| prometheus.persistence.size | string | `"2Gi"` |  |
| receiver_type | string | `"rtlsdr"` |  |
| replicaCount | int | `1` |  |
| tz | string | `"America/New_York"` |  |