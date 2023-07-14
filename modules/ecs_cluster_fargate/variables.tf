variable "region" {}
variable "environment" {} // 'dev' or 'prod'
variable "environment-suffix" {
  default = {
    dev = "-dev"
    stg = "-stg"
    prod = ""
  }
}
variable "base_name" {}