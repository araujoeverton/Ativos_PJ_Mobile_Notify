module "sg_ativos_notify" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "sg-${var.sg_name}"
  description = "Grupo de segurança para serviço de usuário com portas personalizadas abertas dentro do VPC e PostgreSQL aberto publicamente"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = var.ingress_cidr
  ingress_rules            = var.ingress_rules
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