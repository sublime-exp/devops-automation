FROM jenkins/jenkins:lts-jdk17

USER root

# Install Docker
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release docker.io

# Hardcoding the Kubernetes version
RUN K8S_VERSION="v1.26.0" && \
    echo "K8S_VERSION: ${K8S_VERSION}" && \
    curl -LO "https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/amd64/kubectl" && \
    echo "Downloaded kubectl from: https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl && \
    rm -rf /var/lib/apt/lists/*

# Add Jenkins to docker group
RUN usermod -aG docker jenkins

USER jenkins
