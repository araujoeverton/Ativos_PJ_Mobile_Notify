output "repository_url" {
  value = aws_ecr_repository.main.repository_url
  description = "URL do repositório ECR"
}

output "repository_arn" {
  value = aws_ecr_repository.main.arn
  description = "ARN do repositório ECR"
}