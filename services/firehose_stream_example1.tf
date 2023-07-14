module "firehose_stream_example1" {
  source                = "../../../../modules/firehose_stream_s3"
  base_name             = "Example1"
  s3_bucket_arn         = module.s3_bucket_example1.arn
  s3_prefix             = "example1/" # Dynamic partitioning have to be activated manually, not support in Terraform v0.14.4: "example1/!{partitionKeyFromQuery:sn}/!{timestamp:yyyy/MM/dd/HH}/"
  buffer_interval       = 600
  glue_schema_database  = split(":", module.glue_data_catalog_example.database_id)[1]
  glue_schema_table     = "example1"
  environment           = var.environment
  region                = var.region
}