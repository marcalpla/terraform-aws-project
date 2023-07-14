variable "region" {}
variable "environment" {} // 'dev' or 'prod'
variable "environment-suffix" {
  default = {
    dev = "-dev"
    prod = ""
  }
}
variable "base_name" {}

variable "crawler" {
  type = map
  default = {}
}
# Usage example:
# crawler = {
#   CrawlerName1 = {
#     s3_bucket     = "bucket"
#     s3_prefix     = "/folder/subfolder"
#     table_prefix  = "crawler_name_1_"
#     schedule      = ""
#   },
#   CrawlerName2 = {
#     s3_bucket     = "bucket"
#     s3_prefix     = ""
#     table_prefix  = "crawler_name_1_"
#     schedule      = "cron(7,37 * * * ? *)"
#   }
# }