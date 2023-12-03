#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Install Crossplane
kubectl create namespace $CROSSPLANE_NS
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane crossplane-stable/crossplane --version $CROSSPLANE_VERSION --namespace $CROSSPLANE_NS --create-namespace
