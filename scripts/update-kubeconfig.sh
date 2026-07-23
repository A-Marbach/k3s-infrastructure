#!/usr/bin/env bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_DIR="$PROJECT_DIR/terraform"
KUBECONFIG_FILE="$HOME/.kube/config"

CONTROL_PLANE_IP="$(
    terraform -chdir="$TERRAFORM_DIR" \
        output -json server_ipv4_addresses |
    jq -r '."control-plane"'
)"

if [[ -z "$CONTROL_PLANE_IP" || "$CONTROL_PLANE_IP" == "null" ]]; then
    echo "Fehler: Control-Plane-IP konnte nicht gelesen werden."
    exit 1
fi

mkdir -p "$HOME/.kube"

if [[ -f "$KUBECONFIG_FILE" ]]; then
    cp "$KUBECONFIG_FILE" \
       "${KUBECONFIG_FILE}.backup-$(date +%Y%m%d-%H%M%S)"
fi

echo "Hole kubeconfig von $CONTROL_PLANE_IP ..."

ssh "artur@$CONTROL_PLANE_IP" \
    "sudo cat /etc/rancher/k3s/k3s.yaml" \
    > "$KUBECONFIG_FILE"

sed -i \
    "s#https://127.0.0.1:6443#https://$CONTROL_PLANE_IP:6443#" \
    "$KUBECONFIG_FILE"

chmod 600 "$KUBECONFIG_FILE"

echo
echo "Aktueller Kubernetes-API-Server:"
grep 'server:' "$KUBECONFIG_FILE"

echo
kubectl get nodes
