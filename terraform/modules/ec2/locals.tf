locals {
  user_data_files = {
    rhel         = "${path.module}/userdata/rhel.sh"
    ubuntu       = "${path.module}/userdata/ubuntu.sh"
  }
  user_data = templatefile(
    local.user_data_files[var.platform],
    {
      ec2_name = var.ec2_name
    }
  )
}
