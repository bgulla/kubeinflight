
install:
	helm upgrade --install -n flightaware --create-namespace flightaware ./charts/kubeinflight 

delete:
	helm delete flightaware -n flightaware
