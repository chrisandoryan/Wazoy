# Visibility Enhancement (VE) for CTF Challenges with Wazuh Integration

## Overview
This framework helps create web exploitation CTF challenges with custom logging that integrates with Wazuh for real-time monitoring.

## Directory Structure
- `challenges/`: Contains individual CTF challenges.
- `templates/`: Contains templates for logger and sample challenges.
- `wazuh/`: Contains custom decoders and rules for Wazuh.

## Creating a New Challenge
1. Copy the challenge template:
   ```sh
   cp -r templates/challenge-template/ challenges/challenge1/

