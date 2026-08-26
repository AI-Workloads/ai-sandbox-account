terraform {
  backend "s3" {
    bucket       = "epmt-terraform-state"
    key          = "dev/aws-poc-account-dev.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}
