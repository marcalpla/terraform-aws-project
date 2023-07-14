module "iot_topic_firehose_example" {
  source                = "../../../../modules/iot_topic_firehose"
  base_name             = "Example"
  topic_filter          = "example/example"
  where_clause          = "IsUndefined(message) = True"
  firehose_stream_name  = module.firehose_stream_example1.name
  environment           = var.environment
  region                = var.region
}