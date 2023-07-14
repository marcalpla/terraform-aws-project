module "api_gateway_allow_cloudwatch_global" {
  source = "../../../../modules/api_gateway_allow_cloudwatch_global"
  region = var.region
}
