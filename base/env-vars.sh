#!/bin/bash

# Self Info
export SELF_INFO_EMAIL="your_git@email.com"
export SELF_INFO_NAME="Your Name"

# Crossplane
export CROSSPLANE_NS="crossplane-system"
export CROSSPLANE_VERSION="1.13.2"

# GCP
export CONTROL_PLANE_NAME=local-control-plane
export GCP_PROJECT_DES_NAME=GitOps-learning01

export GCP_PROJECT=gitops-learning01
export GCP_SERVICE_ACCOUNT_NAME=root-ca
export GCP_SERVICE_ACCOUNT_FULL_NAME=$GCP_SERVICE_ACCOUNT_NAME@gitops-learning01.iam.gserviceaccount.com
export GCP_SERVICE_ACCOUNT_KEYFILE=your_absolute_path_to_repository_folder/local-control-plane/gcloud/creds.json
export GCP_REGION=asia-southeast1
export GCP_ZONE=asia-southeast1-b

# Network
export GKE_NETWORK_NAME=gl-alpha-nw-0

# Subnet
export GKE_SUBNET_NAME=gl-alpha-subnet-0
export GKE_CLUSTER_SECONDARY_RANGE_NAME=gl-alpha-pods
export GKE_SERVICES_SECONDARY_RANGE_NAME=gl-alpha-services

# Firewall
export GKE_FIREWALL_ALLOW_SSH_RULES_NAME=gl-alpha-allow-ssh
export GKE_FIREWALL_ALLOW_HTTP_RULES_NAME=gl-alpha-allow-http
export GKE_FIREWALL_ALLOW_HTTPS_RULES_NAME=gl-alpha-allow-https
export FIREWALL_ALLOW_ROOT_CA_NAME=allow-root-ca
export FIREWALL_ALLOW_NGINX_INGRESS=allow-nginx-ingress

# NAT
export GKE_NAT_CLOUD_ROUTER_NAME=gl-alpha-nat-router
export GKE_NAT_GATEWAY_NAME=gl-alpha-nat-gateway

# Reverse external static ip address
export ARGOCD_REVERSE_EXTERNAL_STATIC_IP_ADDRESS_NAME=argocd-ingress-static-ip

# Peer
export NETWORK_PEERING_NAME=gl-alpha-default-peer

# Cluster
export GKE_CLUSTER_NAME=gl-alpha-private-controller-cluster-0
export GKE_SUBNET_NAME_FULL_PATH=projects/$GCP_PROJECT/regions/$GCP_REGION/subnetworks/$GKE_SUBNET_NAME
export GKE_NETWORK_NAME_FULL_PATH=projects/$GCP_PROJECT/global/networks/$GKE_NETWORK_NAME
export GKE_ZONE=asia-southeast1-b ## Actually, you can use $GCP_ZONE
export GKE_NODE_LOCATIONS=asia-southeast1-b
export GKE_MACHINE_TYPE=e2-custom-2-8192
export GKE_NUM_NODES=3 # default=3
export GKE_TOTAL_MAX_NODES=3
export GKE_TOTAL_MIN_NODES=1
export GKE_MAX_PODS_PER_NODE=50
export GKE_MIN_CPU=1
export GKE_MIN_MEMORY=1
export GKE_MAX_CPU=6
export GKE_MAX_MEMORY=24
export GKE_MAX_PODS_PER_NODE=50
export GKE_MASTER_IPV4_CIDR=172.16.0.0/28
export GKE_IMAGE_TYPE=COS_CONTAINERD
export GKE_DISK_TYPE=pd-balanced
export GKE_DISK_SIZE=100
export GKE_ADDONS=HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver
export GKE_LABELS=gl-environment=alpha,instance-type=kubernetes,team=one-man-squad

# Compute Engine
export VM_NAME=gl-bastion-host

# Cloud Workstation
export WORKSTATION_CLUSTER_NAME=$CONTROL_PLANE_NAME-ws-cluster
export WORKSTATION_CONFIG_NAME=$CONTROL_PLANE_NAME-ws-config
export WORKSTATION_NAME=$CONTROL_PLANE_NAME-ws
export WORKSTATION_ROOT_CA_SERVICE_ACCOUNT_PATH=/home/user/.config/gcloud/root-ca.json
