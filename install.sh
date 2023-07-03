#!/bin/sh

if [ $# -lt 3 ]; then
  echo "usage: ./install GITHUB_CLIENT_ID GITHUB_CLIENT_SECRET GITHUB_TOKEN"
  exit 1
fi

echo "Installing node modules for Backstage - this may take some time."
GITHUB_TOKEN=$3 yarn install

echo "This will prepare a cluster for Backstage\n"
echo "DO NOT APPLY THIS TO A PRODUCTION CLUSTER\n"
echo "Applying demo Kubernetes resources to your cluster\n"
echo "A namespace 'backstage' will be created and all resources put into this namespace"
echo "The resources being applied are all contained in the ./kubernetes/ directory in this repository"
kubectl apply -k kubernetes/
kubectl create secret generic backstage-oauth-secret -n backstage --from-literal=GITHUB_CLIENT_ID=$1 --from-literal=GITHUB_CLIENT_SECRET=$2
echo "\nKubernetes is configured"
echo "Please run ./startup.sh to start Backstage"
