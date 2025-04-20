module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = "aurora-db-${cluster_name}"
  engine         = var.engine
  engine_version = var.version
  instance_class = var.instance_class_1
  instances = {
    one = {}
    2 = {
      instance_class = var.instance_class_2
    }
  }

  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = "db-subnet-group-${var.cluster_name}"
  security_group_rules = {
    ex1_ingress = {
      cidr_blocks = var.subnet_cidr_blocks
    }
    ex1_ingress = {
      source_security_group_id = "sg-${var.cluster_name}"
    }
  }

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 5

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = {
    Environment = "homolog"
    Terraform   = "true"
  }
}