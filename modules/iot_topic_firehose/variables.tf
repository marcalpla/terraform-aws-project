variable "region" {}
variable "environment" {} // 'dev' or 'prod'
variable "environment-suffix" {
  default = {
    dev = "-dev"
    prod = ""
  }
}
variable "environment-suffix-rule" {
  default = {
    dev = "_dev"
    prod = ""
  }
}
variable "environment-topic-path" {
  default = {
    dev = "dev/"
    prod = ""
  }
}
variable "base_name" {}
variable "topic_filter" {}
variable "where_clause" {
  default = ""
}
variable "firehose_stream_name" {}