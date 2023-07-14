variable "region" {}
variable "bucket" {}

variable "lambda_function" {
  type = map
}
# Usage example:
# lambda_function = {
#   FunctionName1 = {
#     filter_suffix = ".json"
#     events        = ["s3:ObjectCreated:*"]
#   },
#   FunctionName2 = {
#     filter_suffix = ""
#     events        = ["s3:ObjectCreated:*"]
#   }
# }
