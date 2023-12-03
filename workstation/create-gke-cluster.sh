#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Create a cluster
gcloud container clusters create $GKE_CLUSTER_NAME \
  --zone $GKE_ZONE \
  --node-locations $GKE_NODE_LOCATIONS \
  --max-pods-per-node $GKE_MAX_PODS_PER_NODE \
  --image-type $GKE_IMAGE_TYPE \
  --disk-type $GKE_DISK_TYPE \
  --disk-size $GKE_DISK_SIZE \
  --machine-type $GKE_MACHINE_TYPE \
  --num-nodes $GKE_NUM_NODES \
  --network $GKE_NETWORK_NAME_FULL_PATH \
  --subnetwork $GKE_SUBNET_NAME_FULL_PATH \
  --cluster-secondary-range-name $GKE_CLUSTER_SECONDARY_RANGE_NAME \
  --services-secondary-range-name $GKE_SERVICES_SECONDARY_RANGE_NAME \
  --enable-master-authorized-networks \
  --enable-private-nodes \
  --enable-ip-alias \
  --master-ipv4-cidr $GKE_MASTER_IPV4_CIDR \
  --monitoring SYSTEM \
  --metadata disable-legacy-endpoints=true \
  --security-posture standard \
  --workload-vulnerability-scanning disabled \
  --addons $GKE_ADDONS \
  --enable-autoupgrade \
  --enable-autorepair \
  --max-surge-upgrade 1 \
  --max-unavailable-upgrade 0 \
  --labels $GKE_LABELS \
  --binauthz-evaluation-mode DISABLED \
  --no-enable-managed-prometheus \
  --no-shielded-integrity-monitoring \
  --no-shielded-secure-boot \
  --no-enable-basic-auth \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --enable-autoscaling \
  --total-min-nodes=$GKE_TOTAL_MIN_NODES \
  --total-max-nodes=$GKE_TOTAL_MAX_NODES \
  --enable-autoprovisioning \
  --enable-autoprovisioning-autorepair \
  --enable-autoprovisioning-autoupgrade \
  --min-cpu $GKE_MIN_CPU \
  --min-memory $GKE_MIN_MEMORY \
  --max-cpu $GKE_MAX_CPU \
  --max-memory $GKE_MAX_MEMORY \
  --node-taints CriticalAddonsOnly=true:NoSchedule \
  --service-account $GCP_SERVICE_ACCOUNT_FULL_NAME \
  --async
