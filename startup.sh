#!/bin/sh

export AUTH_GITHUB_CLIENT_ID=$(kubectl get secret github-oauth-secret -o json | jq -r ".data.GITHUB_CLIENT_ID | @base64d")
export AUTH_GITHUB_CLIENT_SECRET=$(kubectl get secret github-oauth-secret -o json | jq -r ".data.GITHUB_CLIENT_SECRET | @base64d")

yarn dev
