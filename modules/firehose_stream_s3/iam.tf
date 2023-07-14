resource "aws_iam_role" "kinesis_role" {
  count = length(var.kinesis_stream_arn) > 0 ? 1 : 0
  name = "firehose-${var.base_name}-kinesis-${var.region}${lookup(var.environment-suffix, var.environment)}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "s3_role" {
  name = "firehose-${var.base_name}-s3-${var.region}${lookup(var.environment-suffix, var.environment)}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "glue_role" {
  count = length(var.glue_schema_table) > 0 ? 1 : 0
  name = "firehose-${var.base_name}-glue-${var.region}${lookup(var.environment-suffix, var.environment)}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "kinesis_policy" {
  count = length(var.kinesis_stream_arn) > 0 ? 1 : 0
  name = "firehose-${var.base_name}-kinesis-${var.region}${lookup(var.environment-suffix, var.environment)}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:DescribeStream",
        "kinesis:GetShardIterator",
        "kinesis:GetRecords",
        "kinesis:ListShards"
      ],
      "Resource": "${var.kinesis_stream_arn}"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "s3_policy" {
  name = "firehose-${var.base_name}-s3-${var.region}${lookup(var.environment-suffix, var.environment)}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {      
      "Effect": "Allow",      
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ],      
      "Resource": [        
        "${var.s3_bucket_arn}",
        "${var.s3_bucket_arn}/${regex("[^!]*", var.s3_prefix)}*"		    
      ]    
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "glue_policy" {
  count = length(var.glue_schema_table) > 0 ? 1 : 0
  name = "firehose-${var.base_name}-glue-${var.region}${lookup(var.environment-suffix, var.environment)}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {      
      "Effect": "Allow",      
      "Action": [
        "glue:GetTable",
        "glue:GetTableVersions"
      ],      
      "Resource": [
        "arn:aws:glue:${var.region}:508409325615:catalog",
        "arn:aws:glue:${var.region}:508409325615:database/${var.glue_schema_database}",
        "arn:aws:glue:${var.region}:508409325615:table/${var.glue_schema_database}/${var.glue_schema_table}"
      ]    
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "kinesis_attachment" {
  count      = length(var.kinesis_stream_arn) > 0 ? 1 : 0
  role       = aws_iam_role.kinesis_role[0].name
  policy_arn = aws_iam_policy.kinesis_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "s3_attachment" {
  role       = aws_iam_role.s3_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "glue_attachment" {
  count      = length(var.glue_schema_table) > 0 ? 1 : 0
  role       = aws_iam_role.glue_role[0].name
  policy_arn = aws_iam_policy.glue_policy[0].arn
}