#!/bin/bash

CONTAINER_ID=$(cat /etc/hostname)
WAZUH_AGENT_NAME="$WAZUH_AGENT_NAME-$CONTAINER_ID"
export WAZUH_AGENT_NAME

echo "Agent will be deployed with name $WAZUH_AGENT_NAME"

envsubst < /tmp/ossec.conf > /var/ossec/etc/ossec.conf
envsubst < /tmp/envoy.yaml > /etc/envoy/envoy.yaml

# sed -i "s:WAZUH_MANAGER_IP:$WAZUH_MANAGER_IP:" /var/ossec/etc/ossec.conf
# sed -i "s:WAZUH_AGENT_NAME:$WAZUH_AGENT_NAME:" /var/ossec/etc/ossec.conf

echo "Starting Cronjobs, Wazuh, and Envoy..."
cron & /var/ossec/bin/wazuh-control start & /usr/local/bin/envoy -c /etc/envoy/envoy.yaml