#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TF_DIR="${SCRIPT_DIR}/../terraform"

tf_output() {
	local key="$1"
	local val
	if ! val=$(terraform -chdir="$TF_DIR" output -raw "$key" 2>/dev/null); then
		echo "Error: failed to read Terraform output '$key'. Have you run 'terraform apply'?" >&2
		exit 1
	fi
	if [ -z "$val" ]; then
		echo "Error: Terraform output '$key' is empty. Run 'terraform apply' or 'terraform apply -refresh-only'." >&2
		exit 1
	fi
	echo "$val"
}

RG="$(tf_output aks_resource_group)"
NAME="$(tf_output aks_cluster_name)"
SUB="$(tf_output subscription_id)"

az aks get-credentials --resource-group "$RG" --name "$NAME" --subscription "$SUB"