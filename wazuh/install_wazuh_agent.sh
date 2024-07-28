#!/bin/bash

# Variables
WAZUH_MANAGER_IP="54.251.190.103"
WAZUH_AGENT_NAME="challenge-agent"

# Install Wazuh agent
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list
apt-get update
apt-get install -y wazuh-agent

# Configure Wazuh agent
sed -i "s/^address=.*/address=${WAZUH_MANAGER_IP}/" /var/ossec/etc/ossec.conf
sed -i "s/^name=.*/name=${WAZUH_AGENT_NAME}/" /var/ossec/etc/ossec.conf

# Enable and start the Wazuh agent
systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent
