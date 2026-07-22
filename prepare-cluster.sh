#!/usr/bin/env bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANSIBLE_DIR="$PROJECT_DIR/ansible"
INVENTORY_FILE="$ANSIBLE_DIR/inventory.ini"

echo "========================================"
echo "1. Ansible-Inventory aktualisieren"
echo "========================================"

"$PROJECT_DIR/scripts/generate-inventory.sh"

CONTROL_PLANE_IP="$(
    ansible-inventory -i "$INVENTORY_FILE" \
        --host k3s-control-plane |
    jq -r '.ansible_host'
)"

WORKER_1_IP="$(
    ansible-inventory -i "$INVENTORY_FILE" \
        --host k3s-worker-1 |
    jq -r '.ansible_host'
)"

WORKER_2_IP="$(
    ansible-inventory -i "$INVENTORY_FILE" \
        --host k3s-worker-2 |
    jq -r '.ansible_host'
)"

echo
echo "========================================"
echo "2. Alte SSH-Hostkeys entfernen"
echo "========================================"

for ip in \
    "$CONTROL_PLANE_IP" \
    "$WORKER_1_IP" \
    "$WORKER_2_IP"
do
    ssh-keygen -R "$ip" >/dev/null 2>&1 || true
done

echo
echo "========================================"
echo "3. Auf SSH warten"
echo "========================================"

for ip in \
    "$CONTROL_PLANE_IP" \
    "$WORKER_1_IP" \
    "$WORKER_2_IP"
do
    echo "Warte auf SSH: $ip"

    until nc -z "$ip" 22 >/dev/null 2>&1; do
        sleep 5
    done

    ssh-keyscan -H "$ip" >> "$HOME/.ssh/known_hosts" 2>/dev/null

    echo "SSH erreichbar: $ip"
done

echo
echo "========================================"
echo "4. Verbindung als artur prüfen"
echo "========================================"

if ansible \
    -i "$INVENTORY_FILE" \
    all \
    -m ping >/dev/null 2>&1
then
    echo "Benutzer artur ist bereits eingerichtet."
    echo "Bootstrap wird übersprungen."
else
    echo "Benutzer artur ist noch nicht verfügbar."
    echo "Bootstrap wird als root ausgeführt."

    ansible-playbook \
        -i "$INVENTORY_FILE" \
        "$ANSIBLE_DIR/bootstrap.yml" \
        -e ansible_user=root
fi

echo
echo "========================================"
echo "5. Verbindung als artur testen"
echo "========================================"

ansible \
    -i "$INVENTORY_FILE" \
    all \
    -m ping

echo
echo "========================================"
echo "6. Hauptkonfiguration ausführen"
echo "========================================"

ansible-playbook \
    -i "$INVENTORY_FILE" \
    "$ANSIBLE_DIR/site.yml"

echo
echo "========================================"
echo "7. kubeconfig aktualisieren"
echo "========================================"

"$PROJECT_DIR/scripts/update-kubeconfig.sh"

echo
echo "========================================"
echo "Cluster erfolgreich bereitgestellt"
echo "========================================"