#!/bin/bash

. $(pwd)/../base/env-vars.sh

# gcloud container clusters describe $GKE_CLUSTER_NAME \
#   --zone $GKE_ZONE | grep masterIpv4CidrBlock

gcloud container clusters describe $GKE_CLUSTER_NAME --zone $GKE_ZONE --format="get(privateClusterConfig.masterIpv4CidrBlock)"
