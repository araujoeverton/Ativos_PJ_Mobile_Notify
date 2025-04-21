resource "aws_db_subnet_group" "db_subnet_group_homolog" {
  subnet_ids = var.subnet_ids
  description = "Grupo de subrede"

  
}

resource "aws_rds_cluster" "aurora_cluster" {
  engine = "aurora-postgresql"
  engine_mode = "provisioned"
  engine_version = "14.6"
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group_homolog.name
  master_username = var.username
  master_password = var.password
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.bkp_window
  storage_encrypted = true
  skip_final_snapshot = true
  apply_immediately = true

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 4
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier = "aurora-instance"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class = "db.serverless"
  engine = aws_rds_cluster.aurora_cluster.engine
  engine_version = aws_rds_cluster.aurora_cluster.engine_version
  apply_immediately = true
}