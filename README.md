# VEnvoy: Envoy + Wazuh for Visibility Enhancement (VE)

## Overview
VEnvoy is a Dockerized Envoy Proxy with a pre-configured Wazuh Agent, designed to enhance the visibility and observability of a CTF challenge. VEnvoy automatically captures HTTP traffic, including both body and headers, and directly transports this data to Wazuh for examination if any issues arise with the challenge.

## Architecture 

![alt text](./graphics/architecture.png)

### Basic Principles

VEnvoy operates as a Man-in-the-Middle (MITM) proxy, but not just for HTTP request. VEnvoy currently supports TCP, HTTP, and UDP connections.

Suppose your CTF challenge operates on port `3000`, you can configure Envoy to listen on port `8000`, where the CTF players will access the challenge via port `8000` as well. Envoy will intercept and log all traffic, then redirect them to the `3000` service. Note that you can pick any port for Envoy to listen.

All traffic passing through Envoy is recorded in two files: *access.log* and *alltaps.json*. 
- access.log: Contains a record of all requests made to the challenge's service.
- alltaps.json: Provides a detailed log of traffic data, including body and header information (available only for HTTP traffic).

Those files will automatically be transported to Wazuh and accessible via Wazuh Dashboard.

## Getting Started
### Setup Your Challenge Container
Well, just do your thing.\
Spawn spawn bang bang challenge development.\
¯\\_(ツ)_/¯

### Sidecar VEnvoy to Challenge Container
A prebuilt version of VEnvoy can be obtained from [Docker Hub](https://hub.docker.com/repository/docker/siahaan/venvoy).

Adjust your `docker-compose.yml` to include VEnvoy container. As a sidecar deployment, one challenge container will need one VEnvoy container.
```
version: '3'

services:
  app-backend:
    build: ./app-backend/
    expose:
      - 5000

  venvoy:
    image: siahaan/venvoy
    environment:
      WAZUH_MANAGER_IP: <ip_to_wazuh_server>
      APP_HOST: app-backend
      APP_PORT: 5000
      ENTRY_PORT: 8082 
    privileged: true 
    user: root 
    ports:
      - 8082:8082
    
```

There are a few things to configure:
- a
- b
- c

### Install Custom Decoder via Wazuh Dashboard

