#!/bin/sh

export AUTH_GITHUB_CLIENT_ID=$(kubectl get secret backstage-oauth-secret -n backstage -o json | jq -r ".data.GITHUB_CLIENT_ID | @base64d")
export AUTH_GITHUB_CLIENT_SECRET=$(kubectl get secret backstage-oauth-secret -n backstage -o json | jq -r ".data.GITHUB_CLIENT_SECRET | @base64d")

export K8S_ACCESS_TOKEN=$(kubectl get secret backstage-service-account-creds -n backstage -o json | jq -r ".data.token | @base64d")
export K8S_API_ENDPOINT=$(kubectl config view -o json --minify --output jsonpath="{.clusters[*].cluster.server}")
export K8S_CA_DATA=$(kubectl config view -o json --flatten --output jsonpath="{.clusters[*].cluster.certificate-authority-data}")

yarn dev
