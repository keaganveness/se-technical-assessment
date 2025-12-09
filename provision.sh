#!/usr/bin/env bash
set -euo pipefail

# Simple bootstrap script for an Ubuntu server.
# It installs k3s (single-node Kubernetes) so we can run our container stack.

if [ "${EUID}" -ne 0 ]; then
  echo "Please run as root, e.g.: sudo ./provision.sh"
  exit 1
fi

echo "[+] Updating apt packages..."
apt-get update -y

echo "[+] Installing basic tools (curl, git)..."
apt-get install -y curl git

# Install k3s only if it's not already installed
if ! command -v k3s >/dev/null 2>&1; then
  echo "[+] Installing k3s (single-node server)..."
  curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --write-kubeconfig-mode=644" sh -
else
  echo "[i] k3s already installed, skipping."
fi

echo "[+] Creating helper profile for kubectl..."
cat >/etc/profile.d/k3s-kubectl.sh <<'EOF'
# Use k3s's kubeconfig and kubectl wrapper
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
alias kubectl='k3s kubectl'
EOF

echo
echo "[✓] Provisioning complete."
echo "Open a new shell OR run: source /etc/profile.d/k3s-kubectl.sh"
echo "Then verify with: kubectl get nodes"