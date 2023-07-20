#!/bin/sh
kubectl delete configmap/backstage-app-config -n backstage
kubectl create configmap  backstage-app-config -n backstage --from-file=app-config.local.yaml=./app-config.local.yaml
