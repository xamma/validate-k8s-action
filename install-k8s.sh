#!/bin/bash
set -eux

curl -sfL https://get.k3s.io | sh -

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> "$GITHUB_ENV"

if ! command -v kubectl &> /dev/null; then
  ln -s /usr/local/bin/k3s /usr/local/bin/kubectl
fi

for i in {1..30}; do
  if kubectl get nodes &>/dev/null; then
    echo "K3s is ready."
    break
  fi
  echo "Waiting for K3s to be ready..."
  sleep 2
done

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
