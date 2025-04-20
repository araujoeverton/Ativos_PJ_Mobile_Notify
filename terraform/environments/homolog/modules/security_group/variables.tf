variable "name_prefix" {
  type = string
  description = "Prefixo para o nome do Security Group"
}

variable "vpc_id" {
  type = string
  description = "ID da VPC"
}

variable "description" {
  type = string
  description = "Descrição do Security Group"
  default = "Managed by Terraform"
}

variable "rules" {
  type = list(object({
    ingress = bool
    protocol = string
    from_port = number
    to_port = number
    cidr_blocks = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    prefix_list_ids = optional(list(string))
    source_security_group_id = optional(string)
    destination_security_group_id = optional(string)
  }))
  description = "Lista de regras de entrada e saída"
  default = []
}