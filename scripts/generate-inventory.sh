#!/usr/bin/env bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_DIR="$PROJECT_DIR/terraform"
INVENTORY_FILE="$PROJECT_DIR/ansible/inventory.ini"

echo "Lese IP-Adressen aus Terraform ..."

SERVER_IPS="$(
    terraform -chdir="$TERRAFORM_DIR" \
        output -json server_ipv4_addresses
)"

CONTROL_PLANE_IP="$(
    jq -r '."control-plane"' <<< "$SERVER_IPS"
)"

WORKER_1_IP="$(
    jq -r '."worker-1"' <<< "$SERVER_IPS"
)"

WORKER_2_IP="$(
    jq -r '."worker-2"' <<< "$SERVER_IPS"
)"

for value in \
    "$CONTROL_PLANE_IP" \
    "$WORKER_1_IP" \
    "$WORKER_2_IP"
do
    if [[ -z "$value" || "$value" == "null" ]]; then
        echo "Fehler: Eine Server-IP fehlt im Terraform-Output."
        exit 1
    fi
done

cat > "$INVENTORY_FILE" <<EOF
[control_plane]
k3s-control-plane ansible_host=$CONTROL_PLANE_IP

[workers]
k3s-worker-1 ansible_host=$WORKER_1_IP
k3s-worker-2 ansible_host=$WORKER_2_IP

[k3s_cluster:children]
control_plane
workers

[all:vars]
ansible_user=artur
ansible_python_interpreter=/usr/bin/python3
EOF

echo
echo "Inventory wurde erzeugt:"
echo "$INVENTORY_FILE"
echo
cat "$INVENTORY_FILE"
