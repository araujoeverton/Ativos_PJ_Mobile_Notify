output "db_subnet_group_id" {
  value       = aws_db_subnet_group.db_subnet_group_homolog.id
  description = "The ID of the created DB subnet group."
}

output "db_subnet_group_name" {
  value       = aws_db_subnet_group.db_subnet_group_homolog.name
  description = "The name of the created DB subnet group."
}

output "aurora_cluster_id" {
  value       = aws_rds_cluster.aurora_cluster.id
  description = "The ID of the created Aurora cluster."
}

output "aurora_cluster_endpoint" {
  value       = aws_rds_cluster.aurora_cluster.endpoint
  description = "The endpoint of the Aurora cluster."
}

output "aurora_cluster_reader_endpoint" {
  value       = aws_rds_cluster.aurora_cluster.reader_endpoint
  description = "The reader endpoint of the Aurora cluster."
}

output "cluster_instance_ids" {
  value       = aws_rds_cluster_instance.cluster_instances.*.id
  description = "A list of IDs of the created Aurora cluster instances."
}