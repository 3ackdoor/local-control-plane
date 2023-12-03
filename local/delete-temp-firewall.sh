#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Delete firewall rules
yes | gcloud compute firewall-rules delete $GKE_FIREWALL_ALLOW_SSH_RULES_NAME

yes | gcloud compute firewall-rules delete $GKE_FIREWALL_ALLOW_HTTP_RULES_NAME

yes | gcloud compute firewall-rules delete $GKE_FIREWALL_ALLOW_HTTPS_RULES_NAME

yes | gcloud compute firewall-rules delete $FIREWALL_ALLOW_ROOT_CA_NAME