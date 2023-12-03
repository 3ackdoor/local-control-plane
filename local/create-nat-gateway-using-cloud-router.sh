#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Create Cloud Router
gcloud compute routers create $GKE_NAT_CLOUD_ROUTER_NAME \
  --network $GKE_NETWORK_NAME_FULL_PATH \
  --region $GCP_REGION \
  --async

# Add a configuration to the router
gcloud compute routers nats create $GKE_NAT_GATEWAY_NAME \
  --router-region $GCP_REGION \
  --router $GKE_NAT_CLOUD_ROUTER_NAME \
  --nat-all-subnet-ip-ranges \
  --no-enable-dynamic-port-allocation \
  --enable-endpoint-independent-mapping \
  --udp-idle-timeout 30s \
  --tcp-established-idle-timeout 1200s \
  --tcp-transitory-idle-timeout 30s \
  --icmp-idle-timeout 30s \
  --tcp-time-wait-timeout 120s \
  --no-enable-logging \
  --auto-allocate-nat-external-ips \
  --async
