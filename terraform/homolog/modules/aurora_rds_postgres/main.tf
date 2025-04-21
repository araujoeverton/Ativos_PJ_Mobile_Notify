resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "db-subnet-group-aurora-${var.cluster_name}"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "Grupo de subnet para Aurora ${var.cluster_name}"
  }
}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = var.cluster_name
  engine                  = var.engine_name
  availability_zones      = var.az
  database_name           = var.db_name
  master_username         = var.db_user
  master_password         = var.db_password
  backup_retention_period = var.bkp_retention
  preferred_backup_window = var.preferred_backup_window
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
}