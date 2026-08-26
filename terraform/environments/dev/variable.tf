variable "default_tags" {
  type = map(string)
  default = {
    "group:opco"             = "Syskraft Ai"
    "group:environment-type" = "DEV"
    "group:application"      = "sandbox"
    "group:service-level"    = "SL Generic"
    "backup-plan"            = "NA"
  }
  description = "Default tags to be applied to resources."
}
