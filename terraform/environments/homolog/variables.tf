variable "aws_region" {
  type = string
  description = "Região da AWS onde os recursos serão criados"
  default = "sa-east-1" # Exemplo: São Paulo
}

variable "environment" {
  type = string
  description = "Ambiente (dev, staging, prod)"
  default = "dev"
}

# --- Variáveis da VPC ---
variable "vpc_name" {
  type = string
  description = "Nome para a VPC"
  default = "my-app-vpc"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block para a VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "Lista de CIDR blocks para as sub-redes públicas"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "Lista de CIDR blocks para as sub-redes privadas"
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  type = list(string)
  description = "Lista de Availability Zones a serem usadas"
  default = ["sa-east-1a", "sa-east-1b"]
}

# --- Variáveis de Security Groups ---
variable "rds_allowed_cidrs" {
  type = list(string)
  description = "Lista de CIDR blocks permitidos para acessar o RDS"
  default = ["0.0.0.0/0"] # Restringir em produção!
}

variable "ecs_allowed_cidrs" {
  type = list(string)
  description = "Lista de CIDR blocks permitidos para acessar o ECS (se aplicável)"
  default = ["0.0.0.0/0"] # Restringir em produção!
}

variable "alb_allowed_cidrs" {
  type = list(string)
  description = "Lista de CIDR blocks permitidos para acessar o ALB"
  default = ["0.0.0.0/0"] # Restringir em produção!
}

# --- Variáveis do Aurora RDS Postgres ---
variable "aurora_cluster_name" {
  type = string
  description = "Nome do cluster Aurora"
  default = "my-app-db"
}

variable "aurora_engine_version" {
  type = string
  description = "Versão do engine Aurora PostgreSQL"
  default = "15.3"
}

variable "aurora_instance_class" {
  type = string
  description = "Classe da instância do Aurora"
  default = "db.t3.small"
}

variable "aurora_allocated_storage" {
  type = number
  description = "Armazenamento alocado para o Aurora (GB)"
  default = 20
}

variable "aurora_master_username" {
  type = string
  description = "Nome de usuário administrador do Aurora"
  default = "admin"
}

variable "aurora_master_password" {
  type = string
  description = "Senha do usuário administrador do Aurora"
  sensitive = true
  default = "yoursecurepassword" # Use um gerenciador de segredos em produção!
}

variable "aurora_skip_final_snapshot" {
  type = bool
  description = "Pular a criação do snapshot final do Aurora na destruição"
  default = true
}

variable "aurora_backup_retention_period" {
  type = number
  description = "Período de retenção de backup do Aurora (dias)"
  default = 7
}

variable "aurora_preferred_backup_window" {
  type = string
  description = "Janela de tempo preferencial para backups do Aurora (UTC)"
  default = "03:00-06:00"
}

variable "aurora_preferred_maintenance_window" {
  type = string
  description = "Janela de tempo preferencial para manutenção do Aurora (UTC)"
  default = "Sun:09:00-Sun:10:00"
}

variable "aurora_instance_count" {
  type = number
  description = "Número de instâncias do cluster Aurora"
  default = 1
}

variable "aurora_publicly_accessible" {
  type = bool
  description = "Tornar as instâncias Aurora acessíveis publicamente"
  default = false
}

# --- Variáveis do ECR ---
variable "ecr_repository_name" {
  type = string
  description = "Nome do repositório ECR"
  default = "my-app-repo"
}

variable "ecr_image_tag_mutability" {
  type = string
  description = "Mutabilidade das tags de imagem do ECR ('MUTABLE' ou 'IMMUTABLE')"
  default = "MUTABLE"
}

# --- Variáveis do ECS ---
variable "ecs_cluster_name" {
  type = string
  description = "Nome do cluster ECS"
  default = "my-app-cluster"
}

variable "ecs_container_name" {
  type = string
  description = "Nome do container na task definition do ECS"
  default = "app"
}

variable "ecs_container_tag" {
  type = string
  description = "Tag da imagem do container a ser usada no ECS"
  default = "latest"
}

variable "ecs_container_port" {
  type = number
  description = "Porta do container exposta pelo ECS"
  default = 80
}

variable "ecs_host_port" {
  type = number
  description = "Porta do host para o container (para Fargate, deve ser a mesma que container_port)"
  default = 80
}

variable "ecs_protocol" {
  type = string
  description = "Protocolo da porta do container (tcp ou udp)"
  default = "tcp"
}

variable "ecs_cpu" {
  type = number
  description = "Unidades de CPU para a task Fargate"
  default = 256
}

variable "ecs_memory" {
  type = number
  description = "Memória (em MB) para a task Fargate"
  default = 512
}

variable "ecs_desired_count" {
  type = number
  description = "Número desejado de tasks rodando no serviço ECS"
  default = 2
}

variable "ecs_assign_public_ip" {
  type = bool
  description = "Atribuir IP público às tasks do ECS (apenas em sub-redes públicas)"
  default = false
}

variable "ecs_enable_container_insights" {
  type = bool
  description = "Habilitar o Container Insights para o cluster ECS"
  default = true
}

variable "ecs_log_retention_days" {
  type = number
  description = "Número de dias para retenção dos logs do ECS no CloudWatch"
  default = 7
}

# --- Variáveis do Load Balancer (Opcional) ---
variable "enable_alb" {
  type = bool
  description = "Habilitar a criação de um Application Load Balancer"
  default = false
}

variable "alb_health_check_path" {
  type = string
  description = "Caminho para o health check do ALB"
  default = "/"
}