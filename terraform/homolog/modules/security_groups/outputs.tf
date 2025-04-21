output "security_group_id" {
  description = "O ID do grupo de segurança criado"
  value       = aws_security_group.meu_security_group.id
}

output "security_group_name" {
  description = "O nome do grupo de segurança"
  value       = aws_security_group.meu_security_group.name_prefix
}

output "security_group_vpc_id" {
  description = "O ID da VPC à qual o grupo de segurança está associado"
  value       = aws_security_group.meu_security_group.vpc_id
}