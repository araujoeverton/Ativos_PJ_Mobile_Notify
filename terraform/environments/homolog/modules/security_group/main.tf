module "sg_ativos_homolog" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "sg-vpc"
  description = "Security group para comunicação da VPC com RDS Postgres"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp" 
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  # Se houver regras de saída (egress), elas também estariam aqui.
  # Exemplo:
  # egress_rules = ["all-all"]
}