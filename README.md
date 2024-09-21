# EC2 Management Scripts

This repository contains Bash scripts designed to simplify managing AWS EC2 instances. It includes scripts for connecting to EC2 via SSH and transferring files between a local machine and an EC2 instance using SCP.

## Scripts

### 1. `connect-ec2.sh`

A Bash script to establish an SSH connection to an EC2 instance, with error checking for IP address format, key pair, and connection success.

#### Usage:
```bash
./connect-ec2.sh
```

The script will prompt you to:
- Enter your public IP address.
- Provide the path to your key pair file (default: `knust`).
- Enter the username for the EC2 instance (default: `ubuntu`).

#### Example:
```bash
./connect-ec2.sh
```

You will be guided through entering the necessary details. The script ensures the key pair file has the correct permissions (`chmod 400`) and checks for connection success.

#### Key Features:
- Validates IP address format.
- Ensures the key pair file exists and applies correct permissions.
- Checks for connection success and provides appropriate feedback.

### 2. `transfer-files-ec2.sh`

This script facilitates secure file transfers between your local machine and an EC2 instance using SCP. It supports both uploading files to and downloading files from the EC2 instance, with input validation at each step.

#### Usage:
```bash
./transfer-files-ec2.sh
```

The script will prompt you to:
- Enter the public IP address of your EC2 instance.
- Provide the path to your key pair file (default: `knust`).
- Enter the username for the EC2 instance (default: `ubuntu`).
- Choose between uploading or downloading a file.
- Provide the local file path and the remote file path on the EC2 instance.

#### Example:

For uploading a file:
```bash
./transfer-files-ec2.sh
```

For downloading a file:
```bash
./transfer-files-ec2.sh
```

You will be prompted for details as the script guides you through the process of transferring files between your local machine and the EC2 instance.

#### Key Features:
- Validates IP address and file paths.
- Allows for both file uploads and downloads.
- Provides detailed error messages and success feedback.

## Prerequisites
- Ensure you have proper access to the EC2 instance and the required key pair.
- You must have `SSH` and `SCP` installed on your machine.

## License
This project is licensed under the MIT License.
