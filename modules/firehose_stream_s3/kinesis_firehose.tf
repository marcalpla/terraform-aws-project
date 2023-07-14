resource "aws_kinesis_firehose_delivery_stream" "stream" {
  name        = "${var.base_name}${lookup(var.environment-suffix, var.environment)}"
  destination = "extended_s3"

  dynamic "kinesis_source_configuration" {
    for_each = length(var.kinesis_stream_arn) > 0 ? [""] : []
    content {
      kinesis_stream_arn  = var.kinesis_stream_arn
      role_arn            = aws_iam_role.kinesis_role[0].arn
    }
  }

  extended_s3_configuration {
    prefix              = var.s3_prefix
    error_output_prefix = "${regex("[^!]*", var.s3_prefix)}result=!{firehose:error-output-type}/"
    role_arn            = aws_iam_role.s3_role.arn
    bucket_arn          = var.s3_bucket_arn

    buffering_size         = var.buffer_size
    buffering_interval     = var.buffer_interval
    compression_format  = length(var.glue_schema_table) > 0 ? "UNCOMPRESSED" : "GZIP"

    dynamic "data_format_conversion_configuration" {
      for_each = length(var.glue_schema_table) > 0 ? [""] : []
      content {
        input_format_configuration {
          deserializer {
            open_x_json_ser_de {}
          }
        }

        output_format_configuration {
          serializer {
            parquet_ser_de {}
          }
        }

        schema_configuration {
          database_name = var.glue_schema_database
          role_arn      = aws_iam_role.glue_role[0].arn
          table_name    = var.glue_schema_table
        }        
      }
    }  
  }

  # When dynamic partitioning will be supported by TF this could be removed
  lifecycle {
      ignore_changes = [
          extended_s3_configuration["prefix"],
          extended_s3_configuration["error_output_prefix"]
      ]
  } 
}

output "name" {
  value = aws_kinesis_firehose_delivery_stream.stream.name
}