resource "aws_s3_bucket" "bucket" {
  bucket = "${var.base_name}-${var.region}${lookup(var.environment-suffix, var.environment)}"
  tags = {
    base_name   = var.base_name
    environment = var.environment
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_server_side_encryption_configuration" {
  count   = var.server_side_encryption ? 1 : 0
  bucket  = aws_s3_bucket.bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle_configuration" {
  count   = length(var.lifecycle_configuration) > 0 ? 1 : 0
  bucket  = aws_s3_bucket.bucket.bucket
  dynamic "rule" {
    for_each = var.lifecycle_configuration
    content {
      id      = rule.key
      filter {
        prefix = rule.value.prefix
      }
      status  = "Enabled"
      dynamic "transition" {
        for_each = rule.value.deep_archive_days > 0 ? [1] : []
        content {
          days          = rule.value.deep_archive_days
          storage_class = "DEEP_ARCHIVE"
        }
      }
      dynamic "expiration" {
        for_each = rule.value.expiration_days > 0 ? [1] : []
        content {
          days = rule.value.expiration_days
        }
      }
    }
  }
}

output "name" {
  value = aws_s3_bucket.bucket.id
}

output "arn" {
  value = aws_s3_bucket.bucket.arn
}