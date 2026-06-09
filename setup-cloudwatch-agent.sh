#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "===================================================="
echo " Starting AWS CloudWatch Agent Setup (Intel/AMD)    "
echo "===================================================="

# 1. Clean up any old installer if it exists
if [ -f "./amazon-cloudwatch-agent.deb" ]; then
    echo "[-] Removing old installer file..."
    rm ./amazon-cloudwatch-agent.deb
fi

# 2. Download the official AMD64 Ubuntu package from AWS
echo "[+] Downloading CloudWatch Agent for Intel/AMD (amd64)..."
wget -q https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

# 3. Install the package
echo "[+] Installing package using dpkg..."
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

# 4. Fix the standard Ubuntu collectd path issue
echo "[+] Creating collectd compatibility paths..."
sudo mkdir -p /usr/share/collectd/
sudo touch /usr/share/collectd/types.db

# 5. Create the configuration JSON file
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

# 6. Apply configuration and start the agent service
echo "[+] Starting CloudWatch Agent service..."
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

echo "===================================================="
echo " SUCCESS: CloudWatch Agent is running!             "
echo " Give it 3-5 minutes to stream disk metrics to AWS. "
echo "===================================================="
