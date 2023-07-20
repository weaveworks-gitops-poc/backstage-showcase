#!/bin/sh

function install_backstage () {
  echo "Installing node modules for Backstage - this may take some time."
  yarn install

  echo "This will prepare a cluster for Backstage"
  echo "Applying demo Kubernetes resources to your cluster"
  echo "A namespace 'backstage' will be created and all resources put into this namespace"
  echo "The resources being applied are all contained in the ./kubernetes/ directory in this repository"
  kubectl apply -k kubernetes/
  kubectl delete secret/backstage-oauth-secret -n backstage
  kubectl create secret generic backstage-oauth-secret -n backstage --from-literal=AUTH_GITHUB_CLIENT_ID=$1 --from-literal=AUTH_GITHUB_CLIENT_SECRET=$2
  echo "Kubernetes is configured"
  echo "Please run ./startup.sh to start Backstage"
}

if [ $# -lt 2 ]; then
  echo "usage: ./install GITHUB_CLIENT_ID GITHUB_CLIENT_SECRET"
  exit 1
fi

echo "DO NOT APPLY THIS TO A PRODUCTION CLUSTER"
while true; do
  read -p "Do you wish to prepare your cluster for this Backstage showcase? " yn
  case $yn in
      [Yy]* ) install_backstage $1 $2; break;;
      [Nn]* ) exit;;
      * ) echo "Please answer y or n.";;
  esac
done

