#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Create a network peering
gcloud compute networks peerings create $NETWORK_PEERING_NAME \
  --network=default \
  --peer-project $GCP_PROJECT \
  --peer-network $GKE_NETWORK_NAME_FULL_PATH \
  --auto-create-routes
