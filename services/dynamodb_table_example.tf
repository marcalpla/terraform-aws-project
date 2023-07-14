module "dynamodb_table_example" {
  source      = "../../../../modules/dynamodb_table"
  base_name   = "Example"
  environment = var.environment
}
