# Github Action for validating K8s manifests and helm charts
A simple action to validate my kubernetes manifests/helm charts.  

## Inputs
- ```folder```: Path to the folder with the manifests in your Repo
- ```type```: **manifest** for k8s yamls or **helm** for helm charts
- ```namespace```: Namespace to install/validate against

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

      # Step 2: Use validate k8s action
      - name: Validate K8s manifests
        uses: xamma/validate-k8s-action@v1.0.0
        with:
          folder: './k8s-manifests'  # relative Path to your chart directory
          type: 'manifest'  # type
          namespace: 'default' # namespace
```