output "db_cluster_endpoint" {
  value = aws_rds_cluster.main.endpoint
  description = "Endpoint do cluster Aurora"
}

output "db_cluster_reader_endpoint" {
  value = aws_rds_cluster.main.reader_endpoint
  description = "Endpoint de leitura do cluster Aurora"
}

output "db_cluster_id" {
  value = aws_rds_cluster.main.id
  description = "ID do cluster Aurora"
}