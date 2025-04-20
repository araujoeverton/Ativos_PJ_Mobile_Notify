terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configura o provider da AWS 
provider "aws" {
  region = "us-east-1"
}

####################################
## CHAMA O MÓDUMO DA VPC
####################################

module "vpc" {
  source = "./modules/vpc/main.tf"
  vpc_sufixo        = var.vpc_sufixo
  bloco_cidr        = var.bloco_cidr
  availability_zones = var.availability_zones
  private_subnets   = var.private_subnets
  public_subnets    = var.public_subnets
  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "homolog"
  }
}

#######################################
## CHAMA O MÓDUMO DOS SECURITY GROUPS
#######################################
module "sg_ativos_notify" {
  source = "./modules/security_groups/main.tf" # Ajuste o caminho se o módulo estiver em outro local

  name        = var.sg_name
  description = "Grupo de segurança para serviço de usuário com portas personalizadas abertas dentro do VPC e PostgreSQL aberto publicamente"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks   = var.ingress_cidr
  ingress_rules         = var.ingress_rules
  ingress_with_cidr_blocks = [
    {
      from_port   = var.from_port
      to_port     = var.to_port
      protocol    = var.protocol
      description = "User-service ports"
      cidr_blocks = var.ingress_cidr
    },
    {
      rule        = var.rule
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

#######################################
## CHAMA O MÓDUMO DO CLUSTER AURORA RDS
#######################################
module "cluster" {
  source = "./modules/aurora_rds_postgres/main.tf" # Ajuste o caminho se o módulo estiver em outro local

  name           = "aurora-db-${var.cluster_name}"
  engine         = var.engine
  engine_version = var.version
  instance_class = var.instance_class_1
  instances = {
    one = {}
    two = {
      instance_class = var.instance_class_2
    }
  }

  vpc_id             = module.vpc.vpc_id # Utiliza o output da VPC
  db_subnet_group_name = "db-subnet-group-${var.cluster_name}"
  security_group_names = [module.sg_ativos_notify.name] # Utiliza o nome do SG criado

  storage_encrypted     = true
  apply_immediately     = true
  monitoring_interval   = 5
  skip_final_snapshot   = true # Recomendado para ambientes de teste/homologação

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = {
    Environment = "homolog"
    Terraform   = "true"
  }
}