#!/bin/bash
sudo apt-get install -y snap curl unzip
curl "https://s3.amazonaws.com/amazon-ssm-region/latest/debian_amd64/amazon-ssm-agent.deb" -o "amazon-ssm-agent.deb"
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo useradd ssm-user
sudo echo 'ssm-user ALL=(ALL) NOPASSWD:ALL'  > /etc/sudoers.d/ssm-agent-users
sudo chmod 440 /etc/sudoers.d/ssm-agent-users
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
IDENTITY_DOC="$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/dynamic/instance-identity/document")"
TAG_NAME="$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/meta-data/tags/instance/Name")"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
