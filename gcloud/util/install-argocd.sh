#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Create argocd namespace
kubectl create namespace argocd

# Install ArgoCD components
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/ha/namespace-install.yaml

# Wait for the container argocd-server-* to be ready
kubectl wait --for=condition=ready pod $(kubectl get pods -n argocd | awk '{if ($1 ~ "argocd-server-") print $1}') --timeout=120s -n argocd
