resource "aws_network_interface" "network_interface" {
  subnet_id       = var.subnet_id
  private_ips     = var.private_ips
  security_groups = var.security_groups
  tags = {
    Name = "${var.base_name}${lookup(var.environment-suffix, var.environment)}"
  }    
}

output "subnet_id" {
  value = aws_network_interface.network_interface.subnet_id
}

output "private_ips" {
  value = aws_network_interface.network_interface.private_ips
}