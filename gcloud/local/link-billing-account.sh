#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Link billing account
gcloud billing projects link $GCP_PROJECT \
  --billing-account=$(gcloud billing accounts list | awk 'NR > 1 {print $1}')
