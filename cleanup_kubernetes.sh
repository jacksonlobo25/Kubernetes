#!/bin/bash

# This script will delete all Kubernetes resources (pods, services, etc.), configmaps, PVCs, and PVs in the dev and prod namespaces.

NAMESPACES=("dev" "prod")

for NAMESPACE in "${NAMESPACES[@]}"; do
  echo "Deleting all Kubernetes resources (pods, services, etc.) in namespace $NAMESPACE..."
  kubectl delete all --all -n $NAMESPACE

  echo "Deleting all ConfigMaps in namespace $NAMESPACE..."
  kubectl delete configmap --all -n $NAMESPACE

  echo "Deleting all PersistentVolumeClaims (PVCs) in namespace $NAMESPACE..."
  kubectl delete pvc --all -n $NAMESPACE

  echo "Deleting all PersistentVolumes (PVs) in namespace $NAMESPACE..."
  kubectl delete pv --all -n $NAMESPACE

  echo "Deleting all Storage Classes (SCs) in namespace $NAMESPACE..."
  kubectl delete sc --all -n $NAMESPACE
done

# echo "Deleting Jenkins Service Accounts (SA) in namespace $NAMESPACE..."
# kubectl delete sa jenkins-admin -n $NAMESPACE

# echo "Deleting Jenkins ClusterRole (CR) in namespace $NAMESPACE..."
# kubectl delete clusterrole jenkins-admin -n $NAMESPACE

# echo "Deleting Jenkins ClusterRole Binding (CRB) in namespace $NAMESPACE..."
# kubectl delete clusterrolebinding jenkins-admin -n $NAMESPACE

echo "Cleanup complete."
