#!/bin/bash

# Update package lists
echo "Updating package lists..."
sudo apt update

# Install required dependencies
echo "Installing required dependencies..."
sudo apt install -y curl unzip

# Download the AWS CLI installation script
echo "Downloading AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the downloaded file
echo "Unzipping AWS CLI package..."
unzip awscliv2.zip

# Run the installer
echo "Installing AWS CLI..."
sudo ./aws/install

# Clean up
echo "Cleaning up..."
rm -rf awscliv2.zip aws

# Verify the installation
echo "Verifying AWS CLI installation..."

echo "************************************************************************************************************"
aws --version
echo "************************************************************************************************************"

echo "AWS CLI installation complete"
