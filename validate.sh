#!/bin/bash
set -e

FOLDER="$1"
TYPE="$2"
NAMESPACE="$3"
KUBECONFIG_PATH="$4"

if [[ -n "$KUBECONFIG_PATH" ]]; then
  export KUBECONFIG="$KUBECONFIG_PATH"
else
  export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
fi

if [[ "$TYPE" == "manifest" ]]; then
  echo "Validating Kubernetes manifests in $FOLDER"
  kubectl apply --dry-run=server -f "$FOLDER" -n "$NAMESPACE"
elif [[ "$TYPE" == "helm" ]]; then
  echo "Validating Helm chart in $FOLDER"
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  helm lint "$FOLDER"
  helm install test-chart "$FOLDER" -n "$NAMESPACE" --dry-run --debug
else
  echo "Invalid type: $TYPE"
  exit 1
fi
