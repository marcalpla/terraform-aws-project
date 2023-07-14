resource "aws_lambda_permission" "allow_bucket" {
  for_each      = var.lambda_function
  action        = "lambda:InvokeFunction"
  function_name = "arn:aws:lambda:${var.region}:508409325615:function:${each.key}"
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.bucket}"
}
