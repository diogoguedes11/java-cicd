#!/bin/bash

set -euo pipefail

ARGO_PASSWORD=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)

echo "Argo CD initial admin password: $ARGO_PASSWORD"

argocd login localhost:8080 --username admin --password  $ARGO_PASSWORD --insecure



