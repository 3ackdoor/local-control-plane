#!/bin/bash

# Change to root user
# sudo su -
cd /

# Do various commands
cat <<EOF | kind create cluster --config -
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF

kubectl cluster-info --context kind-kind

kubectl apply \
  --filename https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

kubectl --namespace crossplane-system \
  create secret generic gcp-creds \
  --from-file key=<(./home/user/local-control-plane/gcloud/vm/get-secret.sh)

. ./install-crossplane.sh
. ./install-provider-gcp.sh