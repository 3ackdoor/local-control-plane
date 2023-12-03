#!/bin/bash

. $(pwd)/../base/env-vars.sh

gcloud compute firewall-rules list \
  --filter "name~^gke-$GKE_CLUSTER_NAME" \
  --format 'table(
        name,
        network,
        direction,
        sourceRanges.list():label=SRC_RANGES,
        allowed[].map().firewall_rule().list():label=ALLOW,
        targetTags.list():label=TARGET_TAGS
    )'
