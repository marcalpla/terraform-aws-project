module "s3_bucket_example1" {
  source      = "../../../../modules/s3_bucket"
  base_name   = "example1"
  environment = var.environment
  region      = var.region
}
