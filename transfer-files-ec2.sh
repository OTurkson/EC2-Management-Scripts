#!/bin/bash

# ASSIGNMENT 2
# Script to transfer files between local machine and EC2 instance using SCP with error checking and default values

# Ask user for the public IP address of the EC2 instance
read -p "What is your instance's public IP address? " ip_address
echo

# Check if the IP address is valid (basic check for 4 octets)
if [[ ! "$ip_address" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: Invalid IP address format."
  exit 1
fi

# Ask user for the path to their SSH key pair file (default is 'knust')
read -e -p "What is the path to your key pair file? [default: keypair] " key_pair
key_pair=${key_pair:-keypair}  # Use 'knust' as default if not provided
echo

# Check if the key pair file exists
if [[ ! -f "$key_pair" ]]; then
  echo "Error: Key pair file not found at '$key_pair'."
  exit 1
fi

# Ask user for the username of the EC2 instance (default is 'ubuntu')
read -p "What is the username of your EC2 instance? [default: ubuntu] " username
#username=$( echo "$username" | tr '[:upper:]' '[:lower:])' #Convert the username to lowercase
username=${username:-ubuntu}  # Use 'ubuntu' as default if not provided
echo

# Ask user for the direction of the file transfer (upload or download)
echo "Is it an upload or download? (use their respective numbers)"
echo "1) Upload"
echo "2) Download"
read direction
#direction={$direction,,} #convert direction to lowercase
direction=${direction:-upload} #Use 'upload' as default direction
echo

# Validate direction input (must be either 'upload' or 'download')
if [[ "$direction" != 1 && "$direction" != "upload" && "$direction" != "2" && "$direction" != "download" ]]; then
  echo "Error: Invalid file transfer direction. Please specify '1' or '2'."
  exit 1
fi

# Ask user for the local file path
read -e -p "What is the local file path? " local_path
echo

# Check if the local file path exists for upload (skip for download)
if [[ ("$direction" == "upload" || "$direction" == "1") && ! -f "$local_path" ]]; then
  echo "Error: Local file '$local_path' not found."
  exit 1
fi

# Ask user for the remote file path (relative to root or home of instance)
read -e -p "What is the remote file path (relative to root or home of the instance)? " remote_path
echo

# Perform the file transfer based on the direction
if [[ "$direction" == "upload" || "$direction" == "1" ]]; then
  # Upload local file to remote EC2 instance
  echo "Uploading file to EC2 instance..."
  scp -i "$key_pair" "$local_path" "$username@$ip_address:$remote_path"
elif [[ "$direction" == "download" || "direction" == "2" ]]; then
  # Download file from remote EC2 instance to local machine
  echo "Downloading file from EC2 instance..."
  scp -i "$key_pair" "$username@$ip_address:$remote_path" "$local_path"
fi

# Check if the SCP command was successful
if [ $? -ne 0 ]; then
  echo "Error: File transfer failed. Please check your details."
  exit 1
else
  echo "File transfer successful!"
fi

exit 0
