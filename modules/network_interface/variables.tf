variable "environment" {} // 'dev' or 'prod'
variable "environment-suffix" {
  default = {
    dev = "-dev"
    prod = ""
  }
}
variable "base_name" {}
variable "subnet_id" {}
variable "private_ips" {}
variable "security_groups" {}