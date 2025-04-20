output "vpc_id" {
  description = "ID da VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "Bloco CIDR da VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets_ids" {
  description = "IDs das sub-redes privadas"
  value       = module.vpc.private_subnets
}

output "public_subnets_ids" {
  description = "IDs das sub-redes públicas"
  value       = module.vpc.public_subnets
}

output "nat_gateway_ids" {
  description = "IDs dos gateways NAT"
  value       = module.vpc.nat_public_ips
}

output "vpn_gateway_id" {
  description = "ID do gateway VPN"
  value       = module.vpc.vpn_gateway_id
}

output "private_route_table_ids" {
  description = "IDs das tabelas de roteamento privadas"
  value       = module.vpc.private_route_table_ids
}

output "public_route_table_ids" {
  description = "IDs das tabelas de roteamento públicas"
  value       = module.vpc.public_route_table_ids
}

output "azs" {
  description = "Zonas de disponibilidade utilizadas"
  value       = module.vpc.azs
}

output "tags_all" {
  description = "Mapa de todas as tags aplicadas à VPC"
  value       = module.vpc.tags_all
}