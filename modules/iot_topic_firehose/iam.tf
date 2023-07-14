resource "aws_iam_role" "role" {
  name = "iot-${var.base_name}Firehose-${var.region}${lookup(var.environment-suffix, var.environment)}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "iot.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "policy" {
  name = "iot-${var.base_name}Firehose-${var.region}${lookup(var.environment-suffix, var.environment)}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "firehose:PutRecord",      
      "Resource": "arn:aws:firehose:${var.region}:508409325615:deliverystream/${var.firehose_stream_name}"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}