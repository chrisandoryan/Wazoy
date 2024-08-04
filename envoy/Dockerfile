# Use the official Envoy image as a base
FROM envoyproxy/envoy:v1.31-latest

ARG WAZUH_MANAGER_IP
ARG WAZUH_AGENT_NAME

# Install Wazuh agent dependencies
RUN apt-get update && \
    apt-get install -y curl apt-transport-https lsb-release gnupg2 cron jq

# Add Wazuh repository and install Wazuh agent
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
    echo "deb https://packages.wazuh.com/4.x/apt/ stable main" > /etc/apt/sources.list.d/wazuh.list && \
    apt-get update && \
    apt-get install -y wazuh-agent

# Copy Envoy and Wazuh configuration files
COPY ./envoy.yaml /etc/envoy/envoy.yaml
COPY ./wazuh-agent/ossec.conf /var/ossec/etc/ossec.conf

COPY ./tap_aggregator.sh /opt/tap_aggregator.sh
RUN chmod +x /opt/tap_aggregator.sh

# Setup cron schedule to aggregate tap logs
COPY ./tap_cron.txt /etc/cron.d/tap_cron
RUN chmod 0644 /etc/cron.d/tap_cron
RUN crontab /etc/cron.d/tap_cron
RUN touch /var/log/cron.log

# Configure Wazuh agent
RUN sed -i "s:WAZUH_MANAGER_IP:${WAZUH_MANAGER_IP}:" /var/ossec/etc/ossec.conf
RUN sed -i "s:WAZUH_AGENT_NAME:${WAZUH_AGENT_NAME}:" /var/ossec/etc/ossec.conf

# Expose ports
EXPOSE 8080 9901

# Start both Envoy and Wazuh agent
CMD ["/bin/bash", "-c", "cron & /var/ossec/bin/wazuh-control start & /usr/local/bin/envoy -c /etc/envoy/envoy.yaml"]
