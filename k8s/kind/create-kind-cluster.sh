#!/bin/bash
wsl use wsl

# Step 1: Update system
sudo apt update -y
sudo apt install -y golang-go curl

# Step 2: Install Kind using curl instead of 'go install'
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Step 3: Create the cluster
kind create cluster --name microservices --config kind-config.yaml
