
resource "aws_instance" "ec2_instance" {
  ami                     = var.ami_id
  availability_zone       = var.avb_zone
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  key_name                = var.key_name
  iam_instance_profile    = var.iam_instance_profile
  vpc_security_group_ids  = var.sg_ids
  user_data               = local.user_data
  disable_api_termination = var.disable_api_termination
  metadata_options {
    http_endpoint          = "enabled"
    http_tokens            = "required"
    instance_metadata_tags = "enabled"
  }
  tags        = merge(tomap({ "Name" = var.ec2_name }), var.tags)
}
