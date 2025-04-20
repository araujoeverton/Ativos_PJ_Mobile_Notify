module "ecs_app" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "ecs-cluster-homolog"

  service_name = "ativos-notify-app-service-homolog"
  desired_count = 2 

  task_definition_family = "minha-app-task-homolog"
  task_definition_network_mode = "awsvpc"
  task_definition_requires_compatibilities = ["FARGATE"]
  task_definition_cpu = 256
  task_definition_memory = 512
  task_definition_container_definitions = jsonencode([
    {
      name = "ativos-notify-container"
      image = "SEU_REGISTRY_ECR/sua-aplicacao:latest" # Substitua pela sua imagem no ECR
      portMappings = [
        {
          containerPort = 8080
          hostPort = 8080
        }
      ]
      environment = [
        {
          name = "SPRING_DATASOURCE_URL"
          value = "jdbc:postgresql://${module.aurora.endpoint}:5432/${var.db_name}" # Ajuste para PostgreSQL e use a saída do seu módulo Aurora
        },
        {
          name = "SPRING_DATASOURCE_USERNAME"
          value = var.db_username
        },
        {
          name = "SPRING_DATASOURCE_PASSWORD"
          value = var.db_password
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = "/ecs/minha-app-logs-homolog"
          awslogs-region = "us-east-1" # Ajuste para a sua região
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  # Configurações de rede para o serviço ECS
  load_balancer = [
    {
      name               = "app-lb-homolog" 
      port               = 80
      protocol           = "HTTP"
      target_group_arn_attribute = "arn" # Ou "name" se você estiver usando o nome
      target_group_arn_param_name  = "target_group_arn"
    }
  ]
  assign_public_ip = true 
  
  # Configurações de segurança
  security_group_ids = [modules.sg.ecs_sg_id] # Substitua pelo ID do seu Security Group para o ECS

  subnet_ids = modules.vpc.private_subnets[*] # Substitua pelas suas subnets privadas

  depends_on = [module.aurora] # Garante que o Aurora seja criado antes do ECS

  tags = {
    Environment = "homolog"
    Terraform   = "true"
  }
}