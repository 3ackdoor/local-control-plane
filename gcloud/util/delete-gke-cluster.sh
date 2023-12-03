#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Delete a cluster
yes | gcloud container clusters delete $GKE_CLUSTER_NAME \
  --zone $GKE_ZONE
