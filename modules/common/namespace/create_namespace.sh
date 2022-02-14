#!/bin/bash
set -ex

CLUSTER_NAME=$1
NAMESPACE_NAME=$2


aws eks update-kubeconfig --name $CLUSTER_NAME

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: ${NAMESPACE_NAME}
  labels:
    istio-injection: enabled
EOF