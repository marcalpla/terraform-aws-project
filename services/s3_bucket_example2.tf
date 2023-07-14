variable "s3_bucket_example2_server_side_encryption" {}
variable "s3_bucket_example2_lifecycle_configuration" {}

module "s3_bucket_example2" {
  source                  = "../../../../modules/s3_bucket"
  base_name               = "example2"
  server_side_encryption  = var.s3_bucket_example2_server_side_encryption
  lifecycle_configuration = var.s3_bucket_example2_lifecycle_configuration
  environment             = var.environment
  region                  = var.region
}
