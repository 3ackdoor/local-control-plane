#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Delete NAT router configuration
yes | gcloud compute routers nats delete $GKE_NAT_GATEWAY_NAME \
  --router-region $GCP_REGION \
  --router $GKE_NAT_CLOUD_ROUTER_NAME 

# Delete Cloud Router
yes | gcloud compute routers delete $GKE_NAT_CLOUD_ROUTER_NAME \
  --region $GCP_REGION
