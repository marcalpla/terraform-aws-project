resource "aws_iam_role" "role" {
  count   = length(var.crawler) > 0 ? 1 : 0
  name = "glue-crawler-${var.base_name}-${var.region}${lookup(var.environment-suffix, var.environment)}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  count   = length(var.crawler) > 0 ? 1 : 0
  name = "glue-crawler-${var.base_name}-${var.region}${lookup(var.environment-suffix, var.environment)}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": ${jsonencode([
        for crawler in var.crawler : 
          "arn:aws:s3:::${crawler.s3_bucket}${crawler.s3_prefix}*"
      ])}
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "attachment_custom" {
  count   = length(var.crawler) > 0 ? 1 : 0
  role       = aws_iam_role.role[0].name
  policy_arn = aws_iam_policy.policy[0].arn
}

resource "aws_iam_role_policy_attachment" "attachment_glue" {
  count   = length(var.crawler) > 0 ? 1 : 0
  role       = aws_iam_role.role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}