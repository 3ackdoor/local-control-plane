#!/bin/bash

. $(pwd)/../base/env-vars.sh

# https://pnatraj.medium.com/how-to-run-gcloud-command-line-using-a-service-account-f39043d515b9

gcloud iam service-accounts create $GCP_SERVICE_ACCOUNT_NAME

gcloud projects add-iam-policy-binding $GCP_PROJECT --member serviceAccount:$GCP_SERVICE_ACCOUNT_FULL_NAME --role "roles/owner"
