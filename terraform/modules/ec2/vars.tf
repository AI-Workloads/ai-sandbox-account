#### EC2 resource  Variables
variable "avb_zone" {}
variable "subnet_id" {}
variable "ec2_count" {
  default = "1"
}
variable "key_name" {}
variable "public_ip" {}
variable "ec2_name" {
  description = "EC2 Instance Name"
}
variable "ami_id" {}
variable "instance_type" {}
variable "sg_ids" {
  description = "Security Group ID"
}
variable "tags" {}
variable "iam_instance_profile" {}
variable "disable_api_termination" {}
