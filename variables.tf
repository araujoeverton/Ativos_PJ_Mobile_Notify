variable "vpc_sufixo" {
  description = "Nome da VPC"
  default     = "ativos-notify"
}

variable "bloco_cidr" {
  description = "Classe de bloco CIDR da VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "sg_name" {
  description = "Nome do Security Group"
  default     = "ativos-notify-sg"
}

variable "ingress_cidr" {
  type    = list(string)
  default = ["10.0.0.0/16"] # Permite tráfego dentro da VPC por padrão
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}

variable "from_port" {
  type    = number
  default = 8080
}

variable "to_port" {
  type    = number
  default = 8080
}

variable "protocol" {
  type    = string
  default = "tcp"
}

variable "rule" {
  type    = string
  default = "postgresql-public"
}

variable "cluster_name" {
  description = "Nome do cluster Aurora"
  default     = "ativos-db"
}

variable "engine" {
  description = "Engine do Aurora"
  default     = "aurora-mysql"
}

variable "engine_version" {
  description = "Versão do engine do Aurora"
  default     = "5.6" # Escolha uma versão válida
}

variable "instance_class_1" {
  description = "Classe da instância primária do Aurora"
  default     = "db.t2.small"
}

variable "instance_class_2" {
  description = "Classe da instância secundária do Aurora"
  default     = "db.t2.small"
}

variable "subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] # Subnets privadas da VPC
}

variable "enabled_cloudwatch_logs_exports" {
  type    = list(string)
  default = ["error", "general", "slowquery"]
}
