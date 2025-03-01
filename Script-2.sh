#!/bin/bash

# Variables
OVPN_FILE="/path/to/your/config.ovpn"  # Replace with the path to your .ovpn file
USERNAME="zwsXIilK7SxU0s9Z"
PASSWORD="gotM4g5OZe17ixa6UEWi8oTi3Oee7Vk8"
AUTH_FILE="/tmp/vpn_auth.txt"

# Create a temporary credentials file
echo -e "$USERNAME\n$PASSWORD" > "$AUTH_FILE"

# Set strict permissions on the credentials file
chmod 600 "$AUTH_FILE"

# Connect to the VPN
echo "Connecting to VPN..."
sudo openvpn --config "$OVPN_FILE" --auth-user-pass "$AUTH_FILE"

# Clean up the credentials file after disconnecting
rm -f "$AUTH_FILE"
echo "VPN connection closed. Credentials file removed."
