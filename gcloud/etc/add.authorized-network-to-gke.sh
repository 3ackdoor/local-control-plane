#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Add an authorized network to GKE
gcloud container clusters update $GKE_CLUSTER_NAME \
  --enable-master-authorized-networks \
  --master-authorized-networks 0.0.0.0/0

# 0.0.0.0/0 is CIDR IPv4

# gcloud container clusters update $GKE_CLUSTER_NAME \
#   --enable-master-authorized-networks \
#   --master-authorized-networks CIDR1,CIDR2,...
