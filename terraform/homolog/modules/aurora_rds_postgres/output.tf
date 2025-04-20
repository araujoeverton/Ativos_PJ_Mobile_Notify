output "cluster_id" {
  description = "ID do cluster Aurora"
  value       = module.cluster.id
}

output "cluster_arn" {
  description = "ARN do cluster Aurora"
  value       = module.cluster.arn
}

output "cluster_endpoint" {
  description = "Endpoint de leitura/escrita do cluster Aurora"
  value       = module.cluster.endpoint
}

output "cluster_reader_endpoint" {
  description = "Endpoint de leitura do cluster Aurora"
  value       = module.cluster.reader_endpoint
}

output "cluster_master_username" {
  description = "Nome de usuário master do cluster Aurora"
  value       = module.cluster.master_username
  sensitive   = true # Marcar como sensível para não exibir no plano
}

output "cluster_engine" {
  description = "Engine do cluster Aurora"
  value       = module.cluster.engine
}

output "cluster_engine_version" {
  description = "Versão do engine do cluster Aurora"
  value       = module.cluster.engine_version
}

output "cluster_instance_ids" {
  description = "IDs das instâncias do cluster Aurora"
  value       = module.cluster.instance_ids
}

output "cluster_instance_arns" {
  description = "ARNs das instâncias do cluster Aurora"
  value       = module.cluster.instance_arns
}

output "db_subnet_group_name" {
  description = "Nome do grupo de subnets do banco de dados"
  value       = module.cluster.db_subnet_group_name
}

output "security_group_ids" {
  description = "IDs dos security groups associados ao cluster"
  value       = module.cluster.security_group_ids
}

output "cluster_resource_id" {
  description = "ID de recurso exclusivo para o cluster Aurora"
  value       = module.cluster.cluster_resource_id
}

output "cluster_status" {
  description = "Status atual do cluster Aurora"
  value       = module.cluster.status
}

output "tags_all" {
  description = "Mapa de todas as tags aplicadas ao cluster Aurora"
  value       = module.cluster.tags_all
}