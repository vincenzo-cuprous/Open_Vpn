#!/bin/bash

# Predefined username and password
username="zwsXIilK7SxU0s9Z"
password="gotM4g5OZe17ixa6UEWi8oTi3Oee7Vk8"

# Prompt for the path to the .ovpn file
read -p "Enter the full path to the .ovpn file: " ovpn_path

# Check if the file exists
if [[ ! -f "$ovpn_path" ]]; then
  echo "Error: The file '$ovpn_path' does not exist."
  exit 1
fi

# Create a temporary auth file
auth_file=$(mktemp)
echo "$username" > "$auth_file"
echo "$password" >> "$auth_file"

# Modify the .ovpn file to include the auth file
temp_ovpn=$(mktemp)
cp "$ovpn_path" "$temp_ovpn"
echo "auth-user-pass $auth_file" >> "$temp_ovpn"

# Connect to the VPN
echo "Connecting to the VPN using the provided .ovpn file..."
sudo openvpn --config "$temp_ovpn"

# Clean up temporary files
rm -f "$auth_file" "$temp_ovpn"
