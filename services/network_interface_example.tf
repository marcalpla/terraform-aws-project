variable "network_interface_example_subnet_id" {}
variable "network_interface_example_private_ip" {}
variable "network_interface_example_security_group" {}

module "network_interface_example" {
  source          = "../../../../modules/network_interface"
  base_name       = "example"
  environment     = var.environment
  subnet_id       = var.network_interface_example_subnet_id
  private_ips     = [var.network_interface_example_private_ip]
  security_groups = [var.network_interface_example_security_group]
}