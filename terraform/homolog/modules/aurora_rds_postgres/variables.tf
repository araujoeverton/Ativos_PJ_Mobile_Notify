variable "cluster_name" {
    description = "Nome do Cluster Aurora RDS"
    default = "ativos-notify"
}

variable "engine" {
    description = "Engine do RDS"
    default = "aurora-postgresql"
}

variable "version" {
    description = "Versão da Engine"
    default = "14.5"
}

variable "instance_class_1" {
    description = "Classe da instância RDS"
    default = "db.r6g.large"
}

variable "instance_class_2" {
    description = "Classe da instância RDS"
    default = "db.r6g.2xlarge"
}

variable "subnet_cidr_blocks" {
    type = list(string)
    description = "Classe da subnet"
    default = ["10.20.0.0/20"]
}

variable "enabled_cloudwatch_logs_exports" {
    type = list(string)
    description = "Local de exportação de logs do cloudwath"
    default = ["postgresql"]
}