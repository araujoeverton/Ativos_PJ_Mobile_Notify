resource "aws_ecr_repository" "minha_aplicacao" {
  name                 = "minha-aplicacao"
  image_tag_mutability = "MUTABLE" # Ou "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "homolog"
    Project     = "MeuProjeto"
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.minha_aplicacao.repository_url
  description = "URL do repositório ECR"
}