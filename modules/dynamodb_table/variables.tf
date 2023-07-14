variable "environment" {} // 'dev' or 'prod'
variable "environment-suffix" {
  default = {
    dev = "-dev"
    stg = "-stg"
    prod = ""
  }
}
variable "base_name" {}
variable "hash_key" {
  default = "id"
}

variable "attribute" {
  type = map
  default = {
    id = "S"
  }
}
# Usage example:
# attribute = {
#   attributeName1 = "S"
#   attributeName2 = "N"
#   attributeName3 = "S"
# } 

variable "gsi" {
  type = map
  default = {}
}
# Usage example:
# gsi = {
#   gsiName1 = {
#     hash_key  = "attributeName1"
#     range_key = "attributeName2"
#   },
#   gsiName2 = {
#     hash_key  = "attributeName3"
#   }
# }

variable "point_in_time_recovery" {
  type = bool
  default = false
}

variable "server_side_encryption" {
  type = bool
  default = false
}