variable "subnet_ids" {
  type        = list(string)
  description = "A list of VPC subnet IDs for the DB subnet group."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of VPC security group IDs to associate with the Aurora cluster."
}

variable "username" {
  type        = string
  description = "The username for the Aurora PostgreSQL master user."
}

variable "password" {
  type        = string
  description = "The password for the Aurora PostgreSQL master user."
  sensitive   = true # Mark as sensitive to prevent accidental logging
}

variable "backup_retention_period" {
  type        = number
  description = "The number of days to retain backups for."
  default     = 7
}

variable "bkp_window" {
  type        = string
  description = "The daily time range during which automated backups are created."
  default     = "03:00-06:00 UTC"
}