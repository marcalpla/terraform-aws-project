resource "aws_eip" "eip" {
  vpc      = true
  tags = {
    Name = "${var.base_name}${lookup(var.environment-suffix, var.environment)}"
  }  
}