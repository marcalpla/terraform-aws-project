variable "region" {}
variable "environment" {} // 'dev' or 'prod'
variable "environment-suffix" {
  default = {
    dev = "-dev"
    prod = ""
  }
}
variable "base_name" {}
variable "kinesis_stream_arn" {
  default = ""
}
variable "s3_bucket_arn" {}
variable "s3_prefix" {}
variable "buffer_size" {
  default = 128
}
variable "buffer_interval" {
  default = 300  
}

variable "glue_schema_database" {
  default = ""
}
variable "glue_schema_table" {
  default = ""
}