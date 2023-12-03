#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Delete a subnet and secondary range
yes | gcloud compute networks subnets delete $GKE_SUBNET_NAME --region $GCP_REGION 

# Delete a network
yes | gcloud compute networks delete $GKE_NETWORK_NAME
