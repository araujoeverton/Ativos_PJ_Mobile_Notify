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

module "postgresql_cluster" {
  source = "./modules/aurora_rds_postgres"

  cluster_name            = "aurora-ativos-cluster"
  engine_name             = "aurora-postgresql"
  az                      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  db_name                 = "dbativospj"
  db_user                 = "usuarioadmin"
  db_password             = "usuarioadmin"
  bkp_retention           = 7
  preferred_backup_window = "03:00-05:00"
  private_subnet_ids      = module.vpc_rede.private_subnet_ids
}