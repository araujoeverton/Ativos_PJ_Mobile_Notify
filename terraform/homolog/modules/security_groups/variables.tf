variable "sg_nome" {
  type        = string
  description = "Nome base para o Security Group"
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde o Security Group será criado"
}

variable "vpc_sufixo" {
  type        = string
  description = "Sufixo para o nome da VPC (para tags)"
}

variable "descricao" {
  type        = string
  description = "Descricao do Security Group"
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  description = "Lista de regras de entrada"
  default     = []
}