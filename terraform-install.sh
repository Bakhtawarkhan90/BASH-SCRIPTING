#!/bin/bash

# INSTALLING TERRAFORM

# Ensure that your system is up to date
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

# Download HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Verify the GPG key
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package lists
sudo apt update

# Install Terraform
sudo apt-get install terraform

# Display Terraform version"
echo "*******************************************************************************************************"
terraform --version
echo "*******************************************************************************************************"

echo "*******************************************************************************************************"
echo "Terraform has installed sucessfully"
echo "*******************************************************************************************************"
