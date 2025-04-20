variable "cluster_name" {
  type = string
  description = "Nome do cluster Aurora"
}

variable "engine" {
  type = string
  description = "Engine do banco de dados (ex: aurora-postgresql)"
}

variable "engine_version" {
  type = string
  description = "Versão do engine do banco de dados"
}

variable "database_name" {
  type = string
  description = "Nome do banco de dados inicial"
  default = "postgres"
}

variable "master_username" {
  type = string
  description = "Nome de usuário administrador do banco de dados"
}

variable "master_password" {
  type = string
  description = "Senha do usuário administrador do banco de dados"
  sensitive = true
}

variable "vpc_id" {
  type = string
  description = "ID da VPC"
}

variable "subnet_ids" {
  type = list(string)
  description = "Lista de IDs das sub-redes para o RDS"
}

variable "security_group_ids" {
  type = list(string)
  description = "Lista de IDs dos Security Groups para o RDS"
}

variable "instance_class" {
  type = string
  description = "Classe da instância do RDS"
  default = "db.t3.small"
}

variable "allocated_storage" {
  type = number
  description = "Armazenamento alocado em GB"
  default = 20
}

variable "skip_final_snapshot" {
  type = bool
  description = "Pular a criação do snapshot final na destruição"
  default = true
}

variable "backup_retention_period" {
  type = number
  description = "Número de dias para manter os backups"
  default = 7
}

variable "preferred_backup_window" {
  type = string
  description = "Janela de tempo preferencial para backups (UTC)"
  default = "03:00-06:00"
}

variable "preferred_maintenance_window" {
  type = string
  description = "Janela de tempo preferencial para manutenção (UTC)"
  default = "Sun:09:00-Sun:10:00"
}

variable "instance_count" {
  type = number
  description = "Número de instâncias do cluster"
  default = 1
}

variable "publicly_accessible" {
  type = bool
  description = "Tornar as instâncias acessíveis publicamente"
  default = false
}