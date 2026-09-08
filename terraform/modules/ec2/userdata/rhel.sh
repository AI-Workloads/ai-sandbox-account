#!/bin/bash
sudo hostnamectl set-hostname ${var.ec2_name}
sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm  
sudo systemctl enable amazon-ssm-agent  
sudo systemctl start amazon-ssm-agent 
sudo useradd ssm-user
sudo echo 'ssm-user ALL=(ALL) NOPASSWD:ALL'  > /etc/sudoers.d/ssm-agent-users
sudo chmod 440 /etc/sudoers.d/ssm-agent-users
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
IDENTITY_DOC="$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/dynamic/instance-identity/document")"
TAG_NAME="$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/meta-data/tags/instance/Name")"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
