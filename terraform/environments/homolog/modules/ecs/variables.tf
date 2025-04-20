variable "cluster_name" {
  type = string
  description = "Nome do cluster ECS"
}

variable "container_name" {
  type = string
  description = "Nome do container na task definition"
}

variable "image" {
  type = string
  description = "URL da imagem do container (ECR, Docker Hub, etc.)"
}

variable "container_port" {
  type = number
  description = "Porta do container a ser exposta"
  default = 80
}

variable "cpu" {
  type = number
  description = "Unidades de CPU para a task Fargate"
  default = 256
}

variable "memory" {
  type = number
  description = "Memória (em MB) para a task Fargate"
  default = 512
}

variable "desired_count" {
  type = number
  description = "Número desejado de instâncias do serviço ECS"
  default = 1
}

variable "subnet_ids" {
  type = list(string)
  description = "Lista de IDs das sub-redes para o serviço ECS"
}

variable "security_group_ids" {
  type = list(string)
  description = "Lista de IDs dos Security Groups para o serviço ECS"
}

variable "assign_public_ip" {
  type = bool
  description = "Atribuir um IP público às tasks (apenas em sub-redes públicas)"
  default = false
}

variable "target_group_arn" {
  type = string
  description = "ARN do Target Group do Load Balancer (opcional)"
  default = null
}

variable "enable_container_insights" {
  type = bool
  description = "Habilitar o Container Insights para o cluster ECS"
  default = false
}

variable "log_retention_days" {
  type = number
  description = "Número de dias para retenção dos logs no CloudWatch"
  default = 7
}

variable "task_role_arn" {
  type = string
  description = "ARN da IAM Role para a task (opcional)"
  default = null
}

variable "port_mappings" {
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  description = "Mapeamento de portas para o container"
  default = [
    {
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }
  ]
}

variable "tags" {
  type = map(string)
  description = "Mapa de tags a serem aplicadas aos recursos"
  default = {}
}