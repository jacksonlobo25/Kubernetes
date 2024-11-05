#!/bin/bash

# This script will delete all Kubernetes resources (pods, services, etc.), configmaps, PVCs, and PVs.

echo "Deleting all Kubernetes resources (pods, services, etc.)..."
kubectl delete all --all

echo "Deleting all ConfigMaps..."
kubectl delete configmap --all

echo "Deleting all PersistentVolumeClaims (PVCs)..."
kubectl delete pvc --all

echo "Deleting all PersistentVolumes (PVs)..."
kubectl delete pv --all

echo "Deleting all Storage Classes (SCs)..."
kubectl delete sc --all

echo "Deleting all Service Accounts (SA)..."
kubectl delete sa jenkins-admin

echo "Deleting all ClusterRole (CR)..."
kubectl delete clusterrole jenkins-admin

echo "Deleting all ClusterRole Binding(CRB)..."
kubectl delete clusterrolebinding jenkins-admin 

echo "Cleanup complete."
