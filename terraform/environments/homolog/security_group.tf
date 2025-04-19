resource "aws_security_group" "app_sg_homolog" {
  name_prefix = "${var.environment_name}-app-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080 # Porta da aplicação Spring Boot
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["SEU_IP/32", "OUTRO_IP_SE NECESSÁRIO/32"] # Restrinja o acesso
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment_name
  }
}

resource "aws_security_group" "rds_sg_homolog" {
  name_prefix = "${var.environment_name}-rds-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306 # Porta padrão do MySQL/Aurora
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg_homolog.id] # Acesso apenas do SG da aplicação
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment_name
  }
}

output "rds_endpoint_homolog" {
  value = aws_rds_cluster.aurora_cluster_homolog.endpoint
}