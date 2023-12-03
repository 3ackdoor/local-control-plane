#!/bin/bash

echo "#### START ####"

echo "#### DELETE CLOUD WORKSTATION ####" &&
. ./local/delete-cloud-workstation.sh 2>&1 &&

echo "#### DELETE NAT GATEWAY USING CLOUD ROUTER ####" &&
. ./local/delete-nat-gateway.sh 2>&1 &&

echo "#### DELETE FIREWALL ####" &&
. ./local/delete-temp-firewall.sh 2>&1 &&

echo "#### DELETE NETWORK ####" &&
. ./local/delete-temp-network.sh 2>&1 &&

# *NOTE*
# Check the relevant service accounts

# You may want to disable services 
# Ref: https://cloud.google.com/sdk/gcloud/reference/services/disable

echo "#### DONE ####"
