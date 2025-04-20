resource "aws_rds_cluster" "main" {
  cluster_identifier = var.cluster_name
  engine = var.engine
  engine_version = var.engine_version
  database_name = var.database_name
  master_username = var.master_username
  master_password = var.master_password
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot = var.skip_final_snapshot

  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count = var.instance_count
  cluster_identifier = aws_rds_cluster.main.id
  instance_class = var.instance_class
  engine = aws_rds_cluster.main.engine
  engine_version = aws_rds_cluster.main.engine_version
  identifier = "${var.cluster_name}-${count.index + 1}"
  db_subnet_group_name = aws_db_subnet_group.main.name
  publicly_accessible = var.publicly_accessible

  tags = {
    Name = "${var.cluster_name}-${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "main" {
  name_prefix = "${var.cluster_name}-subnet-group-"
  subnet_ids = var.subnet_ids
  description = "Subnet group for ${var.cluster_name}"
}