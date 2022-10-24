
run-local:
	helm upgrade --install -n flightaware --create-namespace flightaware ./charts/kubeinflight 