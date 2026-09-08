locals {
  user_data_files = {
    rhel         = "${path.module}/userdata/rhel.sh"
    ubuntu       = "${path.module}/userdata/ubuntu.sh"
  }
  user_data = file(local.user_data_files[var.platform])
}
