#!/bin/bash

echo "Creating log directories required for Envoy..."
mkdir -p /var/log/envoy
mkdir -p /var/log/envoy/tap
mkdir -p /var/log/envoy/tap/aggregated

CONTAINER_ID=$(cat /etc/hostname)
WAZUH_AGENT_NAME="envoy-agent-$CONTAINER_ID"
export WAZUH_AGENT_NAME

echo "Agent will be deployed with name $WAZUH_AGENT_NAME"

envsubst < /tmp/ossec.conf > /var/ossec/etc/ossec.conf
envsubst < /tmp/envoy.yaml > /etc/envoy/envoy.yaml

echo "Starting Cronjobs, Wazuh, and Envoy..."
cron & /var/ossec/bin/wazuh-control start & /usr/local/bin/envoy -c /etc/envoy/envoy.yaml