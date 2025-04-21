terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc_rede" {
  source        = "./modules/vpc"
  bloco_cidr    = "10.0.0.0/16"
  vpc_sufixo    = "ativos-notify"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "sg_ativos_notify" {
  source     = "./modules/security_groups"
  sg_nome    = "ativos-notify"
  vpc_id     = module.vpc_rede.vpc_id
  vpc_sufixo = module.vpc_rede.vpc_sufixo
  descricao  = "Grupo de seguranca"
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Permitir HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Permitir HTTPS"
    }
  ]
}

module "cluster" {
  source  = "./modules/aurora_rds_postgres"
  name           = "aurora-ativos-pj-homolog"
  engine         = "aurora-postgresql"
  engine_version = "14.5"
  instance_class = "db.r6g.large"
  instances = {
    one = {
      instance_class      = "db.r5.2xlarge"
      publicly_accessible = true
    }
    2 = {
      instance_class = "db.r5g.2xlarge"
    }
  }
  
  autoscaling_enabled      = true
  autoscaling_min_capacity = 1
  autoscaling_max_capacity = 5

  vpc_id               = module.vpc_rede.vpc_id
  db_subnet_group_name = "db-subnet-group"
  security_group_rules = {
    ex1_ingress = {
      cidr_blocks = ["10.20.0.0/20"]
    }
    ex1_ingress = {
      source_security_group_id = "sg-ativos-pj-homolog"
    }
  }

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 5

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Environment = "homolog"
    Terraform   = "true"
  }
}