#!/bin/bash

. $(pwd)/../base/env-vars.sh

. ./util/delete-gke-cluster.sh

yes | gcloud compute addresses delete $ARGOCD_REVERSE_EXTERNAL_STATIC_IP_ADDRESS_NAME --region $GCP_REGION

yes | gcloud compute firewall-rules delete $FIREWALL_ALLOW_NGINX_INGRESS

. ./local/teardown.sh