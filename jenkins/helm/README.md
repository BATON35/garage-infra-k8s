### 1. Add jenkins remote repo to helm and update
    helm repo add jenkins https://charts.jenkins.io
    helm repo update

### 2. Run helm 
    kubectl delete deployments jenkins-jenkins 
    kubectl delete pvc jenkins-jenkins-pvc
    helm uninstall jenkins 
    helm upgrade --install jenkins . -f values.yaml

### 3. Show generated manifest:
    helm template jenkins . -f values.yaml
    helm template jenkins . -f values.yaml > manifest.yaml
    helm get values jenkins -n garage-core




