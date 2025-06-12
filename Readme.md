# Github Action for validating K8s manifests and helm charts
A simple action to validate my kubernetes manifests/helm charts.  

Can use the builtin k3s cluster on the runner OR give your own cluster via KUBECONFIG.  
The Kubeconfig needs to be base64 encrypted.  

## Inputs
- ```folder```: Path to the folder with the manifests in your Repo
- ```type```: **manifest** for k8s yamls or **helm** for helm charts
- ```namespace```: Namespace to install/validate against (optional)
- ```kubeconfig```: Path to kubeconfig when using own cluster (optional)

## Example usage
```yaml
name: Validate k8s manifests

on:
  workflow_dispatch:
  push:
    branches:
      - master

jobs:
  create-release:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout code
      - name: Checkout Helm Manifests
        uses: actions/checkout@v4

      # Step 2: Setup own cluster kubecon (optional)
      - name: Setup kubeconfig
        run: |
          mkdir -p ~/.kube
          echo "${{ secrets.KUBECONFIG_DATA }}" | base64 -d > $HOME/.kube/config
          chmod 600 $HOME/.kube/config

      # Step 3: Use validate k8s action
      - name: Validate K8s manifests
        uses: xamma/validate-k8s-action@v1.0.1
        with:
          folder: ./k8s-manifests  # relative Path to your chart directory
          type: manifest  # type
          namespace: default # namespace
          kubeconfig: $HOME/.kube/config  # If using own cluster omit for using builtin k3s
```
