module "firehose_stream_example3" {
  source                = "../../../../modules/firehose_stream_s3"
  base_name             = "Example3"
  kinesis_stream_arn    = module.kinesis_stream_example.arn
  s3_bucket_arn         = module.s3_bucket_example1.arn
  s3_prefix             = "example3/"
  buffer_interval       = 900
  environment           = var.environment
  region                = var.region
}