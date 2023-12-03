#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Delete Workstation
yes | gcloud workstations delete $WORKSTATION_NAME \
  --cluster=$WORKSTATION_CLUSTER_NAME \
  --config=$WORKSTATION_CONFIG_NAME \
  --region=$GCP_REGION &&

  # Delete Workstation config
  yes | gcloud workstations configs delete $WORKSTATION_CONFIG_NAME \
    --cluster=$WORKSTATION_CLUSTER_NAME \
    --region=$GCP_REGION &&

  # Delete Workstation cluster
  yes | gcloud workstations clusters delete $WORKSTATION_CLUSTER_NAME \
    --region=$GCP_REGION \
    --async
