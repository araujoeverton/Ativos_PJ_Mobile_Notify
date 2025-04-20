data "aws_region" "current" {}

resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  setting {
    name = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  tags = var.tags
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.cluster_name}-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect = "Allow"
      },
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "ecs_task_execution_policy" {
  name = "${var.cluster_name}-task-execution-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          # Adicione outras permissões que sua task precisa aqui
        ],
        Resource = "*"
      },
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}

resource "aws_cloudwatch_log_group" "task_log_group" {
  name = "/ecs/${var.cluster_name}-task"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

resource "aws_ecs_task_definition" "main" {
  family = "${var.cluster_name}-task"
  cpu = var.cpu
  memory = var.memory
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = var.task_role_arn # Adicionado para a role da task, se necessário
  container_definitions = jsonencode([
    {
      name = var.container_name
      image = var.image
      portMappings = var.port_mappings # Tornando portMappings uma variável
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = aws_cloudwatch_log_group.task_log_group.name
          awslogs-region = data.aws_region.current.name
          awslogs-stream-prefix = "ecs"
        }
      }
      # Adicione outras configurações de container conforme necessário (environment, etc.)
    }
  ])

  tags = var.tags
}

resource "aws_ecs_service" "main" {
  name = "${var.cluster_name}-service"
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count = var.desired_count
  launch_type = "FARGATE"
  network_configuration {
    subnets = var.subnet_ids
    security_groups = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  # Condicionalmente cria a configuração do load balancer se target_group_arn for fornecido
  dynamic "load_balancer" {
    for_each = var.target_group_arn != null ? [1] : []
    content {
      target_group_arn = var.target_group_arn
      container_name = var.container_name
      container_port = element(var.port_mappings, 0).containerPort # Assumindo uma porta se LB estiver ativo
    }
  }

  # Removida a dependência direta do aws_lb_listener.http
  # As dependências devem ser gerenciadas no main.tf da raiz, se necessário.

  deployment_controller {
    type = "ECS" # Ou "CODE_DEPLOY" se estiver usando CodeDeploy
  }

  tags = var.tags
}