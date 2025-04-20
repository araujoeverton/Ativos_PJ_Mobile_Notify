resource "aws_ecr_repository" "main" {
  name = var.repository_name

  image_tag_mutability = var.image_tag_mutability

  tags = {
    Name = var.repository_name
  }
}