Wdrożęnie ci\cd na lokanym k8s
1.Instalacjia helm na wsl2
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm repo add jenkins https://charts.jenkins.io
helm repo update

dostosować plik jenkins-values.yaml (najpierw stworzyć i skopiować tam jenkins/jenkins)

helm install jenkins jenkins/jenkins --namespace ci --create-namespace -f jenkins-values.yaml
lub jesli juz istneje upgrade:
helm upgrade --install jenkins jenkins/jenkins \
  -n ci \
  -f jenkins-values/core.yaml \
  -f jenkins-values/storage.yaml \
  -f jenkins-values/rbac.yaml \
  -f jenkins-values/resources.yaml \
  -f jenkins-values/extras.yaml


logowanie do jenkinsa:
user: admin
password: WgRfUe06JCt2K3kMzCHtIH

NOTES:
1. Get your 'admin' user password by running:
  kubectl exec --namespace ci -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  echo http://127.0.0.1:8080
  kubectl --namespace ci port-forward svc/jenkins 8080:8080

3. Login with the password from step 1 and the username: admin
4. Configure security realm and authorization strategy
5. Use Jenkins Configuration as Code by specifying configScripts in your values.yaml file, see documentation: http://127.0.0.1:8080/configuration-as-code and examples: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos

For more information on running Jenkins on Kubernetes, visit:
https://cloud.google.com/solutions/jenkins-on-container-engine

For more information about Jenkins Configuration as Code, visit:
https://jenkins.io/projects/jcasc/
