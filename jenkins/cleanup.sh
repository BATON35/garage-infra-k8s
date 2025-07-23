#!/bin/bash
set -e

NAMESPACE="ci"
RELEASE="jenkins"
PRESERVE_PVC=false

# 🔄 Parsowanie flagi
for arg in "$@"; do
  if [[ "$arg" == "--preserve-pvc" ]]; then
    PRESERVE_PVC=true
  fi
done

echo "🧹 Removing Helm release..."
helm uninstall $RELEASE -n $NAMESPACE || echo "⚠️ Release not found."

if [ "$PRESERVE_PVC" = false ]; then
  echo "🧺 Removing PVCs..."
  kubectl delete pvc jenkins-pvc -n $NAMESPACE --ignore-not-found
  kubectl delete pvc jenkins-jenkins-pvc -n $NAMESPACE --ignore-not-found
else
  echo "📦 PVCs preserved — Jenkins data stays intact."
fi

echo "🗑️ Removing resources labeled app=jenkins..."
kubectl delete all -l app=jenkins -n $NAMESPACE --ignore-not-found

echo "🚧 Removing RBAC components..."
kubectl delete role jenkins-role -n $NAMESPACE --ignore-not-found
kubectl delete rolebinding jenkins-binding -n $NAMESPACE --ignore-not-found
kubectl delete serviceaccount jenkins-sa -n $NAMESPACE --ignore-not-found

echo "📦 Removing ConfigMaps and Secrets..."
kubectl delete configmap jenkins-config -n $NAMESPACE --ignore-not-found
kubectl delete secret jenkins-secret -n $NAMESPACE --ignore-not-found

echo "✅ Cleanup complete for '$RELEASE' in namespace '$NAMESPACE'"
