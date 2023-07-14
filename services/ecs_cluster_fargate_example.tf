module "ecs_cluster_fargate_ai_products" {
  source      = "../../../../modules/ecs_cluster_fargate"
  base_name   = "Example"
  environment = var.environment
  region      = var.region
}