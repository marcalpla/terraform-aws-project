resource "aws_dynamodb_table" "table" {
  name           = "${var.base_name}${lookup(var.environment-suffix, var.environment)}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  server_side_encryption {
    enabled = var.server_side_encryption
  }  

  dynamic "attribute" {
    for_each = var.attribute
    content {
      name = attribute.key
      type = attribute.value
    }
  } 

  dynamic "global_secondary_index" {
    for_each = var.gsi
    content {
      name      = global_secondary_index.key
      hash_key  = global_secondary_index.value.hash_key
      range_key = contains(keys(global_secondary_index.value), "range_key") ? global_secondary_index.value.range_key : null
      projection_type = "ALL"
    }
  }
}