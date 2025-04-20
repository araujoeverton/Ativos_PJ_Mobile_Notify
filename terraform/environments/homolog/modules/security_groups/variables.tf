variable "name_prefix" {
  description = "Prefixo para nomear o security group"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde o security group será criado"
  type        = string
}

variable "description" {
  description = "Descrição do security group"
  type        = string
}

variable "ingress_rules" {
  description = "Lista de regras de entrada (ingress)"
  type = list(object({
    protocol                  = string
    from_port                = number
    to_port                  = number
    cidr_blocks              = optional(list(string))
    ipv6_cidr_blocks         = optional(list(string))
    prefix_list_ids          = optional(list(string))
    source_security_group_id = optional(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "Lista de regras de saída (egress)"
  type = list(object({
    protocol                      = string
    from_port                    = number
    to_port                      = number
    cidr_blocks                  = optional(list(string), ["0.0.0.0/0"])
    ipv6_cidr_blocks             = optional(list(string), ["::/0"])
    prefix_list_ids             = optional(list(string))
    destination_security_group_id = optional(string)
  }))
  default = []
}
