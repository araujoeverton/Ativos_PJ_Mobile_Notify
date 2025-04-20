variable "vpc_name" {
  type = string
  description = "Nome para a VPC"
}

variable "cidr_block" {
  type = string
  description = "CIDR block para a VPC"
}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "Lista de CIDR blocks para as sub-redes públicas"
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "Lista de CIDR blocks para as sub-redes privadas"
}

variable "availability_zones" {
  type = list(string)
  description = "Lista de Availability Zones a serem usadas"
}