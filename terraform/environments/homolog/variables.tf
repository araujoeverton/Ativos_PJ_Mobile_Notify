
variable "environment_name" {
  type    = string
  default = "homolog"
}

variable "db_name" {
  type    = string
  default = "mydb_homolog"
}

variable "db_username" {
  type = string
  default = "environment"
}

variable "db_password" {
  type      = string
  sensitive = true
  default = "@XqNuKeQw123"
}

variable "instance_type" {
  type    = string
  default = "db.t3.small"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}