variable "region" {}
variable "environment" {} // 'dev' or 'prod'
variable "environment-suffix" {
  default = {
    dev = "-dev"
    prod = ""
  }
}
variable "environment-topic-path" {
  default = {
    dev = "/dev"
    prod = ""
  }
}
variable "base_name" {}