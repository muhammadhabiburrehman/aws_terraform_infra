variable "secret_name" {
  type        = string
  description = "Name of the secret"
}

variable "secret_value" {
  type        = string
  description = "Secret value"
  sensitive   = true
}
