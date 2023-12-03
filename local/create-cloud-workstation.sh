#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Create Workstation cluster
gcloud workstations clusters create $WORKSTATION_CLUSTER_NAME \
  --labels=workstation=$CONTROL_PLANE_NAME \
  --region=$GCP_REGION \
  --network=$GKE_NETWORK_NAME_FULL_PATH \
  --subnetwork=$GKE_SUBNET_NAME_FULL_PATH

# Create Workstation config
gcloud workstations configs create $WORKSTATION_CONFIG_NAME \
  --labels=workstation=$CONTROL_PLANE_NAME \
  --network-tags=$GKE_NETWORK_NAME \
  --cluster=$WORKSTATION_CLUSTER_NAME \
  --region=$GCP_REGION \
  --replica-zones=asia-southeast1-b,asia-southeast1-a
  --machine-type=e2-standard-4 \
  --container-predefined-image=codeoss \
  --pd-disk-type=pd-standard \
  --pd-disk-size=200 \
  --pd-reclaim-policy=delete \
  --pool-size=0 \
  --idle-timeout=7200 \
  --service-account="$GCP_SERVICE_ACCOUNT_FULL_NAME"
  ### --container-command="eval \$(ssh-agent) && gcloud secrets versions access 1 --secret=SSH_PRIVATE_KEY_LOCAL_CONTROL_PLANE --project=gitops-learning01 --format='get(payload.data)' | tr '_-' '/+' | base64 -d | ssh-add - >/dev/null"

# Create Workstation
gcloud workstations create $WORKSTATION_NAME \
  --cluster=$WORKSTATION_CLUSTER_NAME \
  --config=$WORKSTATION_CONFIG_NAME \
  --region=$GCP_REGION \
  --labels=workstation=$CONTROL_PLANE_NAME
