output "vpc_id" {
  description = "O ID da VPC criada"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "O bloco CIDR da VPC"
  value       = aws_vpc.vpc.cidr_block
}

output "private_subnet_ids" {
  description = "Uma lista dos IDs das sub-redes privadas"
  value       = aws_subnet.private_subnets.*.id
}

output "public_subnet_ids" {
  description = "Uma lista dos IDs das sub-redes públicas"
  value       = aws_subnet.public_subnets.*.id
}

output "availability_zones" {
  description = "As zonas de disponibilidade utilizadas"
  value       = var.availability_zones
}

output "internet_gateway_id" {
  description = "O ID do Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  description = "O ID da tabela de rotas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "O ID da tabela de rotas privada"
  value       = aws_route_table.private.id
}
output "vpc_sufixo" {
  description = "O sufixo do nome da VPC"
  value       = var.vpc_sufixo
}