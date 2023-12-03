#!/bin/bash

echo "#### START ####"

echo "#### CREATE PROJECT ####" &&
. ./local/create-project.sh > /dev/null 2>&1 &&

echo "#### WAITING FOR PROJECT INITIALIZATION... ####" &&
sleep 60 &&

echo "#### LINK BILLING ACCOUNT ####" &&
. ./local/link-billing-account.sh > /dev/null 2>&1 &&

echo "#### SET GCLOUD CONFIG ####" &&
. ./local/set-gcloud-config.sh > /dev/null 2>&1 &&

echo "#### CREATE SERVICE ACCOUNT ####" &&
. ./local/create-service-account.sh > /dev/null 2>&1 &&

echo "#### DOWNLOAD SERVICE ACCOUNT ####" &&
. ./local/download-service-account.sh > /dev/null 2>&1 &&

echo "#### CREATE NETWORK ####" &&
. ./local/create-temp-network.sh > /dev/null 2>&1 &&

echo "#### CREATE FIREWALL ####" &&
. ./local/create-temp-firewall.sh > /dev/null 2>&1 &&

echo "#### CREATE NAT GATEWAY USING CLOUD ROUTER ####" &&
. ./local/create-nat-gateway-using-cloud-router.sh > /dev/null 2>&1 &&
sleep 60 &&

echo "#### CREATE CLOUD WORKSTATION ####" &&
. ./local/create-cloud-workstation.sh > /dev/null 2>&1 &&

echo "#### DONE ####"