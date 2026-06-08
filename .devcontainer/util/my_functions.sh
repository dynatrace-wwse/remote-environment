#!/bin/bash
# ======================================================================
#          ------- Custom Functions -------                            #
#  Space for adding custom functions so each repo can customize as.    # 
#  needed.                                                             #
# ======================================================================


customFunction(){
  printInfoSection "This is a custom function that calculates 1 + 1"

  printInfo "1 + 1 = $(( 1 + 1 ))"

}

deployOpentelemetryDemo(){

  NAMESPACE="opentelemetry-demo"

  printInfoSection "Installing latest Opentelemetry Demo in NS='$NAMESPACE' from https://opentelemetry.io/docs/demo/kubernetes-deployment/"

  helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
  
  helm install opentelemetry-demo open-telemetry/opentelemetry-demo --namespace $NAMESPACE --create-namespace

  printWarn "$NAMESPACE is quite heavy and might take a while to schedule all pods"
  waitForAllReadyPods "$NAMESPACE"

  # Expose frontend-proxy via nginx ingress (replaces legacy NodePort)
  registerApp "otel-demo" "$NAMESPACE" "frontend-proxy" 8080

}

undeployOpentelemetryDemo(){

  printInfoSection "Uninstalling Opentelemetry Demo"

  helm uninstall opentelemetry-demo --namespace opentelemetry-demo
  
  printInfo "Deleting namespace opentelemetry-demo"

  kubectl delete namespace opentelemetry-demo
}

exposeOnHttp(){
  # Apps are served on HTTP (80) directly by the nginx ingress controller —
  # no host-level port redirect needed (legacy iptables 80->30100 removed).
  printInfoSection "Apps are exposed on HTTP (80) via nginx ingress at http://$PUBLIC_IP"
}