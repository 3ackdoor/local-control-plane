#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Ref: https://kubernetes.github.io/ingress-nginx/deploy/#gce-gke:~:text=For%20private%20clusters,for%20more%20detail.
# Allow GKE master nodes access to port 8443/tcp on worker nodes
gcloud compute firewall-rules create $FIREWALL_ALLOW_NGINX_INGRESS \
  --network $GKE_NETWORK_NAME \
  --action ALLOW \
  --direction INGRESS \
  --source-ranges $GKE_MASTER_IPV4_CIDR \
  --rules tcp:8443 \
  --target-tags $(./util/get-target-tags-from-view-existing-firewall-rules.sh)
