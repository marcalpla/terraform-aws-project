variable "network_load_balancer_example_vpc" {}
variable "network_load_balancer_example_certificate_arn" {}

module "network_load_balancer_example" {
  source          = "../../../../modules/network_load_balancer"
  base_name       = "example"
  environment     = var.environment
  vpc             = var.network_load_balancer_example_vpc
  subnets         = [module.network_interface_example.subnet_id]
  certificate_arn = var.network_load_balancer_example_certificate_arn
  target_id       = sort(module.network_interface_example.private_ips)[0]
  target_port     = 8000
}