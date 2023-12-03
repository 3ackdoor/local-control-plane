#!/bin/bash

. $(pwd)/../base/env-vars.sh

gcloud compute addresses create $ARGOCD_REVERSE_EXTERNAL_STATIC_IP_ADDRESS_NAME --region $GCP_REGION
