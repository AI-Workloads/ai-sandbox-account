
resource "aws_instance" "ec2_instance" {
  ami                     = var.ami_id
  availability_zone       = var.avb_zone
  instance_type           = var.instance_type
  public_ip               = var.public_ip
  subnet_id               = var.subnet_id
  key_name                = var.key_name
  iam_instance_profile    = var.iam_instance_profile
  vpc_security_group_ids  = var.sg_ids
  user_data               = <<EOF
#!/bin/bash
sudo hostnamectl set-hostname ${var.ec2_name}
sudo useradd ssm-user
sudo echo 'ssm-user ALL=(ALL) NOPASSWD:ALL'  > /etc/sudoers.d/ssm-agent-users
sudo chmod 440 /etc/sudoers.d/ssm-agent-users
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
IDENTITY_DOC="$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/dynamic/instance-identity/document")"
TAG_NAME="$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/meta-data/tags/instance/Name")"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
	EOF
  disable_api_termination = var.disable_api_termination
  metadata_options {
    http_endpoint          = "enabled"
    http_tokens            = "required"
    instance_metadata_tags = "enabled"
  }
  tags        = merge(tomap({ "Name" = var.ec2_name }), var.default_tags)
}
