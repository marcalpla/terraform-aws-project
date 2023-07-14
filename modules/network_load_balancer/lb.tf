resource "aws_lb" "lb" {
  name                        = "${var.base_name}${lookup(var.environment-suffix, var.environment)}"
  internal                    = false
  load_balancer_type          = "network"
  subnets                     = var.subnets
  enable_deletion_protection  = true
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "${var.base_name}${lookup(var.environment-suffix, var.environment)}"
  port        = var.target_port
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = var.vpc
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = var.target_id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "TLS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

