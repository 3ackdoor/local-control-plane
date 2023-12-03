#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Create a temporary GCE instance
gcloud compute instances create $VM_NAME \
  --subnet $GKE_SUBNET_NAME_FULL_PATH \
  --scopes cloud-platform \
  --zone $GCP_ZONE \
  --machine-type n2-custom-2-3072 \
  --async

export CLIENT_IP=$(gcloud compute instances describe gl-bastion-host --zone asia-southeast1-b \
  --format="value(networkInterfaces[0].networkIP)")
