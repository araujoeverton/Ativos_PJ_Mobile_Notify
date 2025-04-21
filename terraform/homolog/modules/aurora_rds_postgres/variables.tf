variable "cluster_name" {
    type = string
    description = "Nome do cluster"
}
  
variable "engine_name" {
  type = string
  description = "Engine do RDS Aurora"
} 

variable "az" {
  type = list(string)
  description = "Lista de zonas de disponibilidade"
}

variable "db_name" {
    type = string
    description = "Nome do banco de dados"
}

variable "db_user" {
    type = string
    description = "Usuário do banco de dados"
}
  
variable "db_password" {
    type = string
    description = "Senha do banco de dados"
}

variable "bkp_retention" {
    type = number
    description = "Quantidade de dias para manter os backups"

}

variable "preferred_backup_window" {
    type = string
    description = "Janela de tempo do backup"
}
variable "private_subnet_ids" {
  type        = list(string)
  description = "Lista de IDs das subnets privadas para o grupo de subnets do DB"
}