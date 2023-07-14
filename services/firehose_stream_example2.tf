module "firehose_stream_example2" {
  source                = "../../../../modules/firehose_stream_s3"
  base_name             = "Example2"
  kinesis_stream_arn    = module.kinesis_stream_example.arn
  s3_bucket_arn         = module.s3_bucket_example2.arn
  s3_prefix             = "example2/"
  glue_schema_database  = split(":", module.glue_data_catalog_example.database_id)[1]
  glue_schema_table     = "example2"
  environment           = var.environment
  region                = var.region
}