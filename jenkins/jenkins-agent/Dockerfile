FROM jenkins/inbound-agent:latest

USER root

# Instalacja Helm
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Instalacja kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.28.2/bin/linux/amd64/kubectl \
  && chmod +x kubectl \
  && mv kubectl /usr/local/bin/

USER jenkins
