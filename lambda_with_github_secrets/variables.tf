variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "my_secret" {
  description = "Secret value to inject into Lambda"
  type        = string
  sensitive   = true
}
