variable "vpc_sufixo" {
    description = "Nome da VPC"
    default = "ativos-notify"
}

variable "bloco_cidr" {
    description = "classe de bloco cidr"
    default = "10.0.0.0/16"
}

variable "availability_zones" {
    type    = list(string)
    description = "Zonas de disponibilidade"
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
    type    = list(string)
    description = "Subnets privadas"
    default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] 
}

variable "public_subnets" {
  type = list(string)
  description = "Lista de Subredes públicas"
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}