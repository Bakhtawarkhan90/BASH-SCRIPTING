#!/bin/bash

# Minikube needs Docker, so let's start by updating the system
sudo apt-get update

# Install Docker
sudo apt install -y docker.io

# Start Docker
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker

# Change ownership of the Docker socket
sudo chown $USER /var/run/docker.sock

# Add the current user to the Docker group
sudo usermod -aG docker $USER

# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Install kubectl
sudo snap install kubectl --classic

# To start Minikube, run the following command:
 minikube start
