
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
}

variable "db_password" {
  type      = string
  sensitive = true 
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