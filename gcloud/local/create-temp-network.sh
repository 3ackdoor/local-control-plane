#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Create a network
gcloud compute networks create $GKE_NETWORK_NAME \
  --subnet-mode custom

# Create a subnet and secondary range
gcloud compute networks subnets create $GKE_SUBNET_NAME \
  --region $GCP_REGION \
  --network $GKE_NETWORK_NAME \
  --range 192.168.0.0/20 \
  --secondary-range $GKE_CLUSTER_SECONDARY_RANGE_NAME=10.4.0.0/14,$GKE_SERVICES_SECONDARY_RANGE_NAME=10.0.32.0/20 \
  --enable-private-ip-google-access
