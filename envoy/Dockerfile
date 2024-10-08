# Use the official Envoy image as a base
FROM envoyproxy/envoy:v1.31-latest

# Install Wazuh agent dependencies
RUN apt-get update && \
    apt-get install -y curl apt-transport-https lsb-release gnupg2 cron jq gettext-base

# Add Wazuh repository and install Wazuh agent
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
    echo "deb https://packages.wazuh.com/4.x/apt/ stable main" > /etc/apt/sources.list.d/wazuh.list && \
    apt-get update && \
    apt-get install -y wazuh-agent

# Copy Envoy and Wazuh configuration files
COPY ./envoy.yaml /tmp/envoy.yaml
COPY ./wazuh-agent/ossec.conf /tmp/ossec.conf

COPY ./tap_aggregator.sh /opt/tap_aggregator.sh
RUN chmod +x /opt/tap_aggregator.sh

# Setup cron schedule to aggregate tap logs
COPY ./tap_cron.txt /etc/cron.d/tap_cron
RUN chmod 0644 /etc/cron.d/tap_cron
RUN crontab /etc/cron.d/tap_cron
RUN touch /var/log/cron.log

# Copy and run entrypoint script
COPY ./entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh 

ENTRYPOINT [ "/opt/entrypoint.sh" ]
