output "cluster_arn" {
  value = aws_ecs_cluster.main.arn
  description = "ARN do cluster ECS"
}

output "service_arn" {
  value = aws_ecs_service.main.arn
  description = "ARN do serviço ECS"
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.main.arn
  description = "ARN da task definition do ECS"
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN da IAM Role de execução da task"
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.task_log_group.name
  description = "Nome do grupo de logs do CloudWatch para a task"
}