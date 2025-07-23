#!/bin/bash
set -e

NAMESPACE=ci

kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install jenkins ./helm -f ./helm/values.yaml -n $NAMESPACE

kubectl rollout status deployment/jenkins -n $NAMESPACE

echo "✅ Jenkins deployed. Port-forward:"
echo "kubectl port-forward svc/jenkins 8081:8081 -n $NAMESPACE"

# 📡 Get Jenkins pod name
POD_NAME=$(kubectl get pods -n "$NAMESPACE" -l app=jenkins -o jsonpath="{.items[0].metadata.name}")


# 🚦 Wait until pod is Running (no loop, just wait)
echo "🕒 Waiting for Jenkins pod to enter 'Running' state..."
kubectl wait pod "$POD_NAME" -n "$NAMESPACE" --for=condition=Ready --timeout=120s

# Try to read the password
echo "🔍 Jenkins master password:"
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- cat /var/jenkins_home/secrets/initialAdminPassword || echo "❌ Still not available. Go to jenkins pod logs"

echo "🔐 Registering GitHub SSH fingerprint in Jenkins pod..."
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- mkdir -p /var/jenkins_home/.ssh
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- bash -c "ssh-keyscan github.com >> /var/jenkins_home/.ssh/known_hosts"

