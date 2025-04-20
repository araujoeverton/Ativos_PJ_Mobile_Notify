output "sg_ativos_notify_id" {
  description = "ID do Security Group sg_ativos_notify"
  value       = module.sg_ativos_notify.security_group_id
}

output "sg_ativos_notify_name" {
  description = "Nome do Security Group sg_ativos_notify"
  value       = module.sg_ativos_notify.name
}

output "sg_ativos_notify_arn" {
  description = "ARN do Security Group sg_ativos_notify"
  value       = module.sg_ativos_notify.arn
}

output "sg_ativos_notify_description" {
  description = "Descrição do Security Group sg_ativos_notify"
  value       = module.sg_ativos_notify.description
}

output "sg_ativos_notify_vpc_id" {
  description = "ID da VPC associada ao Security Group sg_ativos_notify"
  value       = module.sg_ativos_notify.vpc_id
}

output "sg_ativos_notify_ingress_rules" {
  description = "Regras de entrada configuradas no Security Group sg_ativos_notify"
  value       = module.sg_ativos_notify.ingress_rules
}

output "sg_ativos_notify_egress_rules" {
  description = "Regras de saída configuradas no Security Group sg_ativos_notify"
  value       = module.sg_ativos_notify.egress_rules
}

output "sg_ativos_notify_tags_all" {
  description = "Mapa de todas as tags aplicadas ao Security Group sg_ativos_notify"
  value       = module.sg_ativos_notify.tags_all
}