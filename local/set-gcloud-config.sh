#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Set GCP default project
gcloud config set project $GCP_PROJECT

# Set GCP default zone
yes | gcloud config set compute/zone $GCP_ZONE

# Enable APIs
yes | gcloud services enable compute.googleapis.com &&
yes | gcloud services enable workstations.googleapis.com &&
yes | gcloud services enable container.googleapis.com &&
yes | gcloud services enable secretmanager.googleapis.com &&
sleep 120 && echo "Enabled APIs!"
