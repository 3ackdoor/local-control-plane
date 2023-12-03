#!/bin/bash

usermod -aG docker $USER
usermod -aG docker root

# Change to root user
# su -
cd /

# Install Docker
apt update
apt install --yes apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt install --yes docker-ce

# Install kubectl
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Go
wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz

# Update PATH env
echo 'export PATH=$PATH:/usr/local/go/bin' | tee -a ~/.bashrc
echo 'export PATH="/root/go/bin:$PATH"' | tee -a ~/.bashrc
echo 'export KUBECONFIG=/kubeconfig.yaml' | tee -a ~/.bashrc
echo 'export BASE_HOST=127.0.0.1.nip.io' | tee -a ~/.bashrc
echo "export SESSION_USER=$(echo "$pwd" | sed 's/\/home\///')" | tee -a ~/.bashrc

# Install Kind
# [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
# chmod +x ./kind
# mv ./kind /usr/local/bin/kind

# Install Git
# apt update
# apt install --yes git

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Reload
source $HOME/.profile
source ~/.bashrc