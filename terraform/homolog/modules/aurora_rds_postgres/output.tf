output "cluster_id" {
  description = "O identificador do cluster RDS PostgreSQL"
  value       = aws_rds_cluster.postgresql.id
}

output "cluster_endpoint" {
  description = "O endpoint de leitura/escrita do cluster RDS PostgreSQL"
  value       = aws_rds_cluster.postgresql.endpoint
}

output "cluster_reader_endpoint" {
  description = "O endpoint de leitura do cluster RDS PostgreSQL"
  value       = aws_rds_cluster.postgresql.reader_endpoint
}

output "cluster_engine" {
  description = "O engine do cluster RDS PostgreSQL"
  value       = aws_rds_cluster.postgresql.engine
}

output "cluster_engine_version" {
  description = "A versão do engine do cluster RDS PostgreSQL"
  value       = aws_rds_cluster.postgresql.engine_version
}

output "cluster_availability_zones" {
  description = "As zonas de disponibilidade do cluster RDS PostgreSQL"
  value       = aws_rds_cluster.postgresql.availability_zones
}

output "cluster_database_name" {
  description = "O nome do banco de dados inicial do cluster RDS PostgreSQL"
  value       = aws_rds_cluster.postgresql.database_name
}

output "cluster_master_username" {
  description = "O nome de usuário master do cluster RDS PostgreSQL"
  value       = aws_rds_cluster.postgresql.master_username
  sensitive   = true
}

output "cluster_backup_retention_period" {
  description = "O período de retenção de backups do cluster RDS PostgreSQL (em dias)"
  value       = aws_rds_cluster.postgresql.backup_retention_period
}

output "cluster_preferred_backup_window" {
  description = "A janela de backup preferencial do cluster RDS PostgreSQL"
  value       = aws_rds_cluster.postgresql.preferred_backup_window
}

output "db_subnet_group_name" {
  description = "O nome do grupo de subnets do banco de dados"
  value       = aws_db_subnet_group.aurora_subnet_group.name
}