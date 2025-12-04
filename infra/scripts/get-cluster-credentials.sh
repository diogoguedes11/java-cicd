#!/bin/bash
set -euo pipefail
RESOURCE_GROUP="rg-java-cicd"
AKS_CLUSTER_NAME="java-cicd-aks"
az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "$AKS_CLUSTER_NAME"