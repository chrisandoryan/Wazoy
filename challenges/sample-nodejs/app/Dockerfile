# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

ARG WAZUH_MANAGER_IP
ARG WAZUH_AGENT_NAME

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl wget gnupg procps

# Add the Wazuh repository and install the Wazuh agent
RUN wget -qO - https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
    echo "deb https://packages.wazuh.com/4.x/apt/ stable main" > /etc/apt/sources.list.d/wazuh.list && \
    apt-get update && \
    apt-get install -y wazuh-agent

# Copy the Wazuh configuration file
COPY ./ossec.conf /var/ossec/etc/ossec.conf

RUN sed -i "s:WAZUH_MANAGER_IP:${WAZUH_MANAGER_IP}:" /var/ossec/etc/ossec.conf
RUN sed -i "s:WAZUH_AGENT_NAME:${WAZUH_AGENT_NAME}:" /var/ossec/etc/ossec.conf

# Define the command to run the application
# CMD ["npm", "start"]
CMD ["/bin/bash", "-c", "/var/ossec/bin/wazuh-control start & npm start"]