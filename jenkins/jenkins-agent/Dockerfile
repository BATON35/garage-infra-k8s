FROM jenkins/inbound-agent:latest

USER root

# Instalacja Helm
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Instalacja kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.28.2/bin/linux/amd64/kubectl \
  && chmod +x kubectl \
  && mv kubectl /usr/local/bin/

# Instalacja Java 21 (Temurin)
RUN curl -LO https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.3%2B9/OpenJDK21U-jdk_x64_linux_hotspot_21.0.3_9.tar.gz \
  && mkdir -p /opt/java/openjdk \
  && tar -xzf OpenJDK21U-jdk_x64_linux_hotspot_21.0.3_9.tar.gz -C /opt/java/openjdk \
  && rm OpenJDK21U-jdk_x64_linux_hotspot_21.0.3_9.tar.gz

# Ustawienie JAVA_HOME i ścieżki
ENV JAVA_HOME=/opt/java/openjdk/jdk-21.0.3+9
ENV PATH="$JAVA_HOME/bin:$PATH"


USER jenkins
