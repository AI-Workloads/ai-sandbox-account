output "ec2_id" {
  value = aws_instance.ec2_instance.id
}

output "ec2_instance_type" {
  value = aws_instance.ec2_instance.instance_type
}

output "ec2_ami_id" {
  value = aws_instance.ec2_instance.ami
}
