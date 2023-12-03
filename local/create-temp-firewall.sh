#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Create firewall rules
gcloud compute firewall-rules create $GKE_FIREWALL_ALLOW_SSH_RULES_NAME \
  --network $GKE_NETWORK_NAME \
  --source-ranges 0.0.0.0/0 \
  --allow tcp:22

gcloud compute firewall-rules create $GKE_FIREWALL_ALLOW_HTTP_RULES_NAME \
  --network $GKE_NETWORK_NAME \
  --source-ranges 0.0.0.0/0 \
  --allow tcp:80

gcloud compute firewall-rules create $GKE_FIREWALL_ALLOW_HTTPS_RULES_NAME \
  --network $GKE_NETWORK_NAME \
  --source-ranges 0.0.0.0/0 \
  --allow tcp:443

gcloud compute firewall-rules create $FIREWALL_ALLOW_ROOT_CA_NAME \
  --direction INGRESS \
  --priority 1000 \
  --network $GKE_NETWORK_NAME \
  --action ALLOW \
  --rules all \
  --source-service-accounts $GCP_SERVICE_ACCOUNT_FULL_NAME
