#!/bin/bash

. $(pwd)/../base/env-vars.sh

gcloud compute firewall-rules list \
  --filter "name~^gke-$GKE_CLUSTER_NAME" \
  --format 'value(targetTags.list())' \
  --limit 1
