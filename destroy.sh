#!/usr/bin/env bash
set -euo pipefail

# Helper script to remove all resources created by this demo.

echo "[!] This will delete all resources in the 'webapp' namespace."
read -p "Are you sure? [y/N]: " confirm

if [[ "${confirm}" != "y" && "${confirm}" != "Y" ]]; then
  echo "Aborted."
  exit 0
fi

echo "[+] Deleting namespace 'webapp'..."
kubectl delete namespace webapp --ignore-not-found=true

echo
echo "[✓] Cleanup complete."