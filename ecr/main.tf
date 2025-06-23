provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "my_repo" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Environment = "dev"
  }
}
