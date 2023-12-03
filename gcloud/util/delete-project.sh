#!/bin/bash

. $(pwd)/../base/env-vars.sh

yes | gcloud projects delete $GCP_PROJECT