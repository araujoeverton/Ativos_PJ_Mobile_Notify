variable "sg_name" {
  description = "Nome do grupo de segurança"
  default = "ativos_notify"
}

variable "ingress_cidr" {
  type = list(string)
  description = "Nome do grupo de segurança"
  default = ["10.10.0.0/16"]
}

variable "ingress_rules" {
  type = list(string)
  description = "Nome do grupo de segurança"
  default = ["https-443-tcp"]
}

variable "from_port" {
  description = "Porta de Ingress"
  default = 8080
}

variable "to_port" {
  description = "Porta de Ingress"
  default = 8090
}

variable "protocol" {
  description = "Protocolo Cidr"
  default = "tcp"
}

variable "rule" {
  description = "Rule Cidr"
  default = "postgresql-tcp"
}