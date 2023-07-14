resource "aws_ecs_cluster" "cluster" {
  name = "${var.base_name}${lookup(var.environment-suffix, var.environment)}"
}

resource "aws_ecs_cluster_capacity_providers" "cluster_capacity_providers" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }
}