terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Ou a versão mais recente que você preferir
    }
  }

  required_version = ">= 1.1" # Versão mínima do Terraform
}

# Configure o provider AWS
provider "aws" {
  region = var.aws_region # Região da AWS onde os recursos serão criados
}

# --- Módulo da VPC ---
module "vpc" {
  source = "./modules/vpc"

  vpc_name            = var.vpc_name
  cidr_block          = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones  = var.availability_zones
}

# --- Módulo de Security Groups ---
module "security_groups" {
  source = "./modules/security-groups"

  vpc_id = module.vpc.vpc_id

  # Security Group para o Aurora RDS
  rds_sg_name = "aurora-rds-sg"
  rds_sg_rules = [
    {
      ingress = true
      protocol = "tcp"
      from_port = 5432
      to_port = 5432
      cidr_blocks = var.rds_allowed_cidrs # Restringir o acesso ao RDS
      description = "Allow PostgreSQL access"
    }
  ]

  # Security Group para o ECS
  ecs_sg_name = "ecs-sg"
  ecs_sg_rules = [
    {
      ingress = true
      protocol = "tcp"
      from_port = 80
      to_port = 80
      cidr_blocks = var.ecs_allowed_cidrs # Restringir o acesso ao ECS (se aplicável)
      description = "Allow HTTP access to ECS"
    },
    {
      ingress = true
      protocol = "tcp"
      from_port = 443
      to_port = 443
      cidr_blocks = var.ecs_allowed_cidrs # Restringir o acesso HTTPS ao ECS (se aplicável)
      description = "Allow HTTPS access to ECS"
    }
  ]

  # Security Group para o Load Balancer ( caso exista um )
  alb_sg_name = "alb-sg"
  alb_sg_rules = [
    {
      ingress = true
      protocol = "tcp"
      from_port = 80
      to_port = 80
      cidr_blocks = var.alb_allowed_cidrs # Restringir o acesso ao ALB
      description = "Allow HTTP access to ALB"
    },
    {
      ingress = true
      protocol = "tcp"
      from_port = 443
      to_port = 443
      cidr_blocks = var.alb_allowed_cidrs # Restringir o acesso HTTPS ao ALB
      description = "Allow HTTPS access to ALB"
    }
  ]
}

# --- Módulo do Aurora RDS Postgres ---
module "aurora_postgres" {
  source = "./modules/aurora-postgres"

  cluster_name            = var.aurora_cluster_name
  engine                  = "aurora-postgresql"
  engine_version          = var.aurora_engine_version
  instance_class          = var.aurora_instance_class
  allocated_storage       = var.aurora_allocated_storage
  master_username         = var.aurora_master_username
  master_password         = var.aurora_master_password
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnet_ids
  security_group_ids      = [module.security_groups.rds_sg_id]
  skip_final_snapshot     = var.aurora_skip_final_snapshot
  backup_retention_period = var.aurora_backup_retention_period
  preferred_backup_window = var.aurora_preferred_backup_window
  preferred_maintenance_window = var.aurora_preferred_maintenance_window
  instance_count          = var.aurora_instance_count
  publicly_accessible     = var.aurora_publicly_accessible
}

# --- Módulo do ECR ---
module "ecr_repo" {
  source = "./modules/ecr"

  repository_name       = var.ecr_repository_name
  image_tag_mutability  = var.ecr_image_tag_mutability
}

# --- Módulo do ECS ---
module "ecs_cluster" {
  source = "./modules/ecs"

  cluster_name            = var.ecs_cluster_name
  container_name        = var.ecs_container_name
  image                   = "${module.ecr_repo.repository_url}:${var.ecs_container_tag}"
  cpu                     = var.ecs_cpu
  memory                  = var.ecs_memory
  desired_count           = var.ecs_desired_count
  subnet_ids              = module.vpc.public_subnet_ids # Ou privadas dependendo da sua necessidade
  security_group_ids      = [module.security_groups.ecs_sg_id]
  assign_public_ip        = var.ecs_assign_public_ip
  enable_container_insights = var.ecs_enable_container_insights
  log_retention_days      = var.ecs_log_retention_days
  port_mappings = [
    {
      containerPort = var.ecs_container_port
      hostPort      = var.ecs_host_port
      protocol      = var.ecs_protocol
    }
  ]
  tags = {
    Environment = var.environment
  }
}

# --- Recursos Adicionais (Load Balancer, etc.) ---
# Adicione aqui a configuração do seu Application Load Balancer (ALB)
# Target Group, Listener, etc., se você estiver usando um.
# Certifique-se de usar o security group `module.security_groups.alb_sg_id`.

# Exemplo de um ALB (básico - adapte conforme sua necessidade)
resource "aws_lb" "app_lb" {
  count = var.enable_alb ? 1 : 0

  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security_groups.alb_sg_id]
  subnets            = module.vpc.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "app_tg" {
  count = var.enable_alb ? 1 : 0

  port     = var.ecs_container_port
  protocol = var.ecs_protocol
  vpc_id   = module.vpc.vpc_id

  health_check {
    path     = var.alb_health_check_path
    protocol = var.ecs_protocol
    matcher  = "200"
    interval = 30
    timeout  = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "http" {
  count = var.enable_alb ? 1 : 0

  load_balancer_arn = aws_lb.app_lb[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg[0].arn
  }
}

# Se você precisar de HTTPS, adicione outro listener aqui
# resource "aws_lb_listener" "https" { ... }