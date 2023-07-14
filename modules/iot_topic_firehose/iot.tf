resource "aws_iot_topic_rule" "rule" {
  name        = "${var.base_name}Firehose${lookup(var.environment-suffix-rule, var.environment)}"
  description = "${var.base_name}Firehose${lookup(var.environment-suffix-rule, var.environment)}"
  enabled     = true
  sql         = "SELECT * FROM '${lookup(var.environment-topic-path, var.environment)}${var.topic_filter}'${length(var.where_clause) > 0 ? " WHERE ${var.where_clause}" : ""}"
  sql_version = "2016-03-23"

  firehose {
    delivery_stream_name  = var.firehose_stream_name
    role_arn              = aws_iam_role.role.arn
  } 
}