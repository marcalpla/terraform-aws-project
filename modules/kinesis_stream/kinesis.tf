resource "aws_kinesis_stream" "stream" {
  name        = "${var.base_name}${lookup(var.environment-suffix, var.environment)}"
  shard_count = 1
}

output "arn" {
  value = aws_kinesis_stream.stream.arn
}