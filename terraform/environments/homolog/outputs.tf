output "vpc_id" {
  value = module.vpc.vpc_id
  description = "ID da VPC"
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
  description = "IDs das sub-redes públicas"
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
  description = "IDs das sub-redes privadas"
}

output "rds_endpoint" {
  value = module.aurora_postgres.db_cluster_endpoint
  description = "Endpoint do cluster Aurora RDS"
}

output "ecr_repository_url" {
  value = module.ecr_repo.repository_url
  description = "URL do repositório ECR"
}

output "ecs_cluster_name" {
  value = module.ecs_cluster.cluster_name
  description = "Nome do cluster ECS"
}

output "ecs_service_arn" {
  value = module.ecs_cluster.service_arn
  description = "ARN do serviço ECS"
}

output "alb_dns_name" {
  value = aws_lb.app_lb[0].dns_name
  description = "DNS name do Application Load Balancer (se habilitado)"
  sensitive = false
}