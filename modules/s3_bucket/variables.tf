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

variable "server_side_encryption" {
  type = bool
  default = false
}

variable "lifecycle_configuration" {
  type = map
  default = {}
}
# Usage example:
# lifecycle_configuration = {
#   rule1 = {
#     prefix = "prefix1/"
#     deep_archive_days = 180
#   },
#   rule2 = {
#     prefix = "prefix2/"
#     deep_archive_days = 365
#     expiration_days = 730
#   }
# }