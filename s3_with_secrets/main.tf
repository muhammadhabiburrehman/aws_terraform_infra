provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = var.s3_bucket

  tags = {
    Name        = "My Secret bucket"
    Environment = "Dev"
  }
}
