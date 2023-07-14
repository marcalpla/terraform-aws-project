module "iot_certificate_example" {
  source      = "../../../../modules/iot_certificate"
  base_name   = "example"
  environment = var.environment
  region      = var.region
}