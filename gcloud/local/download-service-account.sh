#!/bin/bash

. $(pwd)/../base/env-vars.sh

gcloud iam service-accounts keys create ./creds.json --iam-account $GCP_SERVICE_ACCOUNT_FULL_NAME