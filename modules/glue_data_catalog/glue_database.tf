resource "aws_glue_catalog_database" "database" {
  name = "${var.base_name}${lookup(var.environment-suffix, var.environment)}"
}

output "database_id" {
  value = aws_glue_catalog_database.database.id
}