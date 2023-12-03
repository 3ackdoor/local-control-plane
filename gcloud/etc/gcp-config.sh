#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Activate the service account
gcloud auth activate-service-account $GCP_SERVICE_ACCOUNT_FULL_NAME --key-file=$GCP_SERVICE_ACCOUNT_KEYFILE

# Set GCP project
yes | gcloud config set project $GCP_PROJECT

# Connect to cluster (also sets current context)
gcloud container clusters get-credentials $GKE_CLUSTER_NAME --zone $GKE_ZONE --project $GCP_PROJECT
