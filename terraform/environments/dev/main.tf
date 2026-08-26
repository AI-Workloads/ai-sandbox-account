module "server1" {
  source                    = "../../modules/ec2"
  ami_id                    = "ami-0056d98d3e05cdbd9"
  key_name                  = "test-key"
  sg_ids                    = flatten(["sg-0c7c16af62ebd394c"])
  ec2_name                  = "le1pocad001"
  avb_zone                  = "eu-west-1a"
  subnet_id                 = "subnet-05d5191209c939561"
  instance_type             = "t2.micro"
  tags                      = merge(var.default_tags, tomap({ "SSM-Automation" = "LinuxTrue" }), tomap({ "PatchGroup" = "STANDARD-REDHAT-ENTERPRISE-LINUX" }))
  iam_instance_profile      = "dcs_iam_ssm"
  disable_api_termination   = "false"
}
