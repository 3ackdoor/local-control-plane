#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Start ssh-agent
eval $(ssh-agent)

# Add SSH private key from Secret Manager to the machine
gcloud secrets versions access 1 --secret="SSH_PRIVATE_KEY_LOCAL_CONTROL_PLANE" --project=$GCP_PROJECT | ssh-add - >/dev/null

# Add Service Account JSON file from Secret Manager to the machine
gcloud secrets versions access 1 --secret="GCP_CREDS_LOCAL_CONTROL_PLANE" --out-file=$WORKSTATION_ROOT_CA_SERVICE_ACCOUNT_PATH

# Config Git information
git config --global user.email $SELF_INFO_EMAIL
git config --global user.name $SELF_INFO_NAME

# Start minikube
minikube start

# Pull GKE KubeConfig context
. ./workstation/pull-gke-kubeconfig.sh

# Find Workstation VM IP Address
export WORKSTATION_VM_IP_ADDRESS=$(gcloud compute instances describe "$(gcloud compute instances list | grep local-control-plane-ws-config | awk '{print $1}')" --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

# Add an authorized network to GKE
gcloud container clusters update $GKE_CLUSTER_NAME \
  --zone $GKE_ZONE \
  --enable-master-authorized-networks \
  --master-authorized-networks $WORKSTATION_VM_IP_ADDRESS/32
