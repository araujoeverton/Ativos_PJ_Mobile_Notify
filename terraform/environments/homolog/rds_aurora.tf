resource "aws_rds_cluster" "aurora_cluster_homolog" {
  cluster_identifier   = "${var.environment_name}-aurora-cluster"
  engine               = "aurora-mysql"
  engine_mode          = "provisioned" # Ou "serverless", dependendo da sua necessidade
  master_username      = var.db_username
  master_password      = var.db_password
  db_cluster_parameter_group_name = "default.aurora-mysql.5.7" # Adapte a versão
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group_homolog.name
  skip_final_snapshot    = true # Evita snapshots finais em ambientes de homologação
}

resource "aws_rds_cluster_instance" "aurora_instance_1_homolog" {
  cluster_identifier   = aws_rds_cluster.aurora_cluster_homolog.id
  instance_class       = var.instance_type
  engine               = aws_rds_cluster.aurora_cluster_homolog.engine
  engine_version       = aws_rds_cluster.aurora_cluster_homolog.engine_version
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group_homolog.name
}

resource "aws_db_subnet_group" "db_subnet_group_homolog" {
  name       = "${var.environment_name}-db-subnet-group"
  subnet_ids = var.subnet_ids
}