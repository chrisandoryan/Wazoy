# Use the official Envoy image as a base
FROM envoyproxy/envoy:v1.31-latest

ARG WAZUH_MANAGER_IP
ARG WAZUH_AGENT_NAME

# Install Wazuh agent dependencies
RUN apt-get update && \
    apt-get install -y curl apt-transport-https lsb-release gnupg2

# Add Wazuh repository and install Wazuh agent
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
    echo "deb https://packages.wazuh.com/4.x/apt/ stable main" > /etc/apt/sources.list.d/wazuh.list && \
    apt-get update && \
    apt-get install -y wazuh-agent

# Copy Envoy and Wazuh configuration files
COPY ./envoy.yaml /etc/envoy/envoy.yaml
COPY ./wazuh-agent/ossec.conf /var/ossec/etc/ossec.conf

# COPY ./wazuh/decoders/envoy_decoder.xml /var/ossec/etc/decoders/envoy_decoder.xml
# COPY ./wazuh/rules/envoy_rules.xml /var/ossec/etc/rules/envoy_rules.xml

# Configure Wazuh agent
RUN sed -i "s:WAZUH_MANAGER_IP:${WAZUH_MANAGER_IP}:" /var/ossec/etc/ossec.conf
RUN sed -i "s:WAZUH_AGENT_NAME:${WAZUH_AGENT_NAME}:" /var/ossec/etc/ossec.conf

# Expose ports
EXPOSE 8080 9000

# Start both Envoy and Wazuh agent
CMD ["/bin/bash", "-c", "/var/ossec/bin/wazuh-control start & /usr/local/bin/envoy -c /etc/envoy/envoy.yaml"]
