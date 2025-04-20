module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${vpc_sufixo}"
  cidr = var.bloco_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "homolog"
  }
}