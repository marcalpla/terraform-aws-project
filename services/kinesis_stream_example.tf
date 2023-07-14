module "kinesis_stream_example" {
  source      = "../../../../modules/kinesis_stream"
  base_name   = "Example"
  environment = var.environment
}