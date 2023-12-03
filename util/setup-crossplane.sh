#!/bin/bash

# current work directory must be at `crossplane` folder path
# to run this script use `./init/setup.sh`

. $(pwd)/../base/env-vars.sh

# Start ssh-agent
eval $(ssh-agent)

# Add SSH private key from Secret Manager to the machine
gcloud secrets versions access 1 --secret="SSH_PRIVATE_KEY_LOCAL_CONTROL_PLANE" --project=gitops-learning01 | ssh-add - >/dev/null

# Start minikube
minikube start

# Install ingress
minikube addons enable ingress

# Install ingress-dns
minikube addons enable ingress-dns

# Install Crossplane
./util/install-crossplane.sh

# Install GCP Provider
./util/install-provider-gcp.sh

# Set env variable with google credentials path to bashrc
[[ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]] && sudo echo 'export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.config/gcloud/application_default_credentials.json' | tee -a ~/.bashrc

# Refresh current shell
source ~/.bashrc

# Set k8s Secret
kubectl create secret \
  generic gcp-secret \
  -n crossplane-system \
  --from-file=creds=$GOOGLE_APPLICATION_CREDENTIALS

# Create a ProviderConfig
cat <<EOF | kubectl apply -f -
apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: $GCP_PROJECT
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-secret
      key: creds
EOF

