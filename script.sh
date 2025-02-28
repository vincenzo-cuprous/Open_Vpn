#!/bin/bash

# Prompt for the path to the .ovpn file
read -p "Enter the full path to the .ovpn file: " ovpn_path

# Check if the file exists
if [[ ! -f "$ovpn_path" ]]; then
  echo "Error: The file '$ovpn_path' does not exist."
  exit 1
fi

# Prompt for the username
read -p "Enter your VPN username: " vpn_username

# Prompt for the password (hidden input)
read -s -p "Enter your VPN password: " vpn_password
echo

# Create a temporary auth file
auth_file=$(mktemp)
echo "$vpn_username" > "$auth_file"
echo "$vpn_password" >> "$auth_file"

# Modify the .ovpn file to include the auth file
temp_ovpn=$(mktemp)
cp "$ovpn_path" "$temp_ovpn"
echo "auth-user-pass $auth_file" >> "$temp_ovpn"

# Connect to the VPN
echo "Connecting to the VPN..."
sudo openvpn --config "$temp_ovpn"

# Clean up temporary files
rm -f "$auth_file" "$temp_ovpn"
