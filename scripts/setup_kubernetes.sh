#!/bin/bash

sudo install -d -m 0755 /etc/apt/keyrings
# Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Kubernetes
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key |\
    sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' |\
    sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update -qq

code_pkgs=(
    # docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    kubectl
)

sudo apt install ${code_pkgs[*]}
