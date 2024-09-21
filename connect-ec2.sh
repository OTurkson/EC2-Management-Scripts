#!/bin/bash

# ASSIGNMENT 1
# Script to connect to an EC2 instance using SSH with error checking and def>

# Prompt the user for their public IP address
read -p "What is your public IP address? " ip_address
echo

# Check if the IP address is valid (basic check for 4 octets)
if [[ ! "$ip_address" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: Invalid IP address format."
  exit 1
fi

# Prompt the user for the path to their key pair file (default is 'knust')
read -e -p "What is the path to your key pair file? [default: knust] " key_p>
key_pair_path=${key_pair_path:-knust}  # Use 'knust' as default if not provi>
echo

# Check if the key pair file exists
if [[ ! -f "$key_pair_path" ]]; then
  echo "Error: Key pair file not found at '$key_pair_path'."
  exit 1
fi

# Prompt the user for the username of the EC2 instance (default is 'ubuntu')
read -p "What is the username of the EC2 instance? [default: ubuntu] " usern>
username=${username:-ubuntu}  # Use 'ubuntu' as default if not provided

# Ensure the user has the right permissions for the key pair (chmod 400)
chmod 400 "$key_pair_path"

# Try to connect to the EC2 instance
echo "Connecting to EC2 instance..."
ssh -i "$key_pair_path" "$username@$ip_address"

# Check if the SSH connection was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to connect to EC2 instance. Please check your details."
  exit 1
else
  echo "Successfully connected to EC2 instance."
fi
