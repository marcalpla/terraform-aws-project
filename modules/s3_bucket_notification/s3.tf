resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.bucket

  dynamic "lambda_function" {
    for_each            = var.lambda_function
    content {
      lambda_function_arn = "arn:aws:lambda:${var.region}:508409325615:function:${lambda_function.key}"
      events              = lambda_function.value.events
      filter_suffix       = lambda_function.value.filter_suffix
    }
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
