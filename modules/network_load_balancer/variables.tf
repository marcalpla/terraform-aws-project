variable "environment" {} // 'dev' or 'prod'
variable "environment-suffix" {
  default = {
    dev = "-dev"
    prod = ""
  }
}
variable "base_name" {}
variable "vpc" {
  
}
variable "subnets" {}
variable "certificate_arn" {}
variable "ssl_policy" {
  default = "ELBSecurityPolicy-2016-08"
}
variable target_id {}
variable target_port {}