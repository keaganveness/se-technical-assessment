#!/usr/bin/env bash
set -euo pipefail

# Simple helper to deploy the entire stack to Kubernetes.
# Assumes:
# - kubectl is installed and configured (on this VM: k3s alias)
# - You have permissions to apply into the cluster

echo "[+] Applying namespace..."
kubectl apply -f k8s/namespace.yaml

echo "[+] Deploying web application..."
kubectl apply -f k8s/app-deployment.yaml
kubectl apply -f k8s/app-service.yaml

echo "[+] Deploying NGINX load balancer and cache..."
kubectl apply -f k8s/nginx-configmap.yaml
kubectl apply -f k8s/nginx-deployment.yaml
kubectl apply -f k8s/nginx-service.yaml

echo
echo "[✓] All resources applied."
echo "You can check status with: kubectl -n webapp get pods,svc"