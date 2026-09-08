#### EC2 resource  Variables
variable "avb_zone" {}
variable "subnet_id" {}
variable "ec2_count" {
  default = "1"
}
variable "key_name" {}
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
variable "platform" {
  description = "Operating system platform"
  type        = string
  validation {
    condition = contains([
      "rhel",
      "ubuntu",
      "amazon_linux",
      "windows"
    ], var.platform)
    error_message = "Platform must be one of: rhel, ubuntu, amazon_linux, windows."
  }
}
