resource "aws_iot_certificate" "certificate" {
  active = true
}

resource "aws_iot_policy" "policy" {
  name = "certificate-${lower(var.base_name)}${lookup(var.environment-suffix, var.environment)}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iot:Publish",
      "Resource": "arn:aws:iot:${var.region}:508409325615:topic${lookup(var.environment-topic-path, var.environment)}/${lower(var.base_name)}/*"
    },
    {
      "Effect": "Allow",
      "Action": "iot:Connect",
      "Resource": "arn:aws:iot:${var.region}:508409325615:client/${lower(var.base_name)}"
    }
  ]
}
POLICY
}

resource "aws_iot_policy_attachment" "policy_attachment" {
  policy = aws_iot_policy.policy.name
  target = aws_iot_certificate.certificate.arn
}

output "public_key" {
  value = aws_iot_certificate.certificate.public_key
}

output "private_key" {
  value = aws_iot_certificate.certificate.private_key
}