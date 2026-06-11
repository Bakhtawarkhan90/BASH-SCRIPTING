#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "===================================================="
echo " Starting AWS CloudWatch Agent Setup (CentOS 7 AMD64) "
echo "===================================================="

# Ensure curl is installed on this CentOS minimal instance
if ! command -v curl &> /dev/null; then
    echo "[+] Installing curl dependency..."
    sudo yum install -y curl
fi

# 1. Clean up any old installer if it exists
if [ -f "./amazon-cloudwatch-agent.rpm" ]; then
    echo "[-] Removing old installer file..."
    rm ./amazon-cloudwatch-agent.rpm
fi

# 2. Download the official CentOS RPM package from AWS
echo "[+] Downloading CloudWatch Agent for CentOS (amd64)..."
curl -sLO https://amazoncloudwatch-agent.s3.amazonaws.com/centos/amd64/latest/amazon-cloudwatch-agent.rpm

# 3. Install the package using yum (handles CentOS 7 local verification cleanly)
echo "[+] Installing package via yum..."
sudo yum localinstall -y ./amazon-cloudwatch-agent.rpm

# 4. Create the configuration JSON file
echo "[+] Generating CloudWatch Agent configuration..."
sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/bin/

cat << 'EOF' | sudo tee /opt/aws/amazon-cloudwatch-agent/bin/config.json > /dev/null
{
  "metrics": {
    "append_dimensions": {
      "InstanceId": "${aws:InstanceId}"
    },
    "metrics_collected": {
      "disk": {
        "measurement": [
          "disk_used_percent"
        ],
        "metrics_collection_interval": 60,
        "resources": [
          "/"
        ]
      }
    }
  }
}
EOF

# 5. Apply configuration and start the agent service
echo "[+] Starting CloudWatch Agent service..."
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

echo "===================================================="
echo " SUCCESS: CloudWatch Agent is running on CentOS 7! "
echo " Give it 3-5 minutes to stream disk metrics to AWS. "
echo "===================================================="
