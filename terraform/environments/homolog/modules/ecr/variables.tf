variable "repository_name" {
  type = string
  description = "Nome do repositório ECR"
}

variable "image_tag_mutability" {
  type = string
  description = "Mutabilidade das tags de imagem ('MUTABLE' ou 'IMMUTABLE')"
  default = "MUTABLE"
}