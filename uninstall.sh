#!/bin/sh

kubectl delete -k kubernetes/
echo "The 'backstage' namespace has been removed"
