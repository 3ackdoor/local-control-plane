#!/bin/bash

. $(pwd)/../base/env-vars.sh

gcloud projects create $GCP_PROJECT --name=$GCP_PROJECT_DES_NAME
