variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "my_secret" {
  description = "Secret value to inject into Lambda"
  type        = string
  sensitive   = true
}
