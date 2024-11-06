#!/bin/bash

# This script will delete all Kubernetes resources (pods, services, etc.), configmaps, PVCs, PVs, and namespaces dev and prod.

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

  echo "Deleting namespace $NAMESPACE..."
  kubectl delete namespace $NAMESPACE
done

echo "Cleanup complete."
