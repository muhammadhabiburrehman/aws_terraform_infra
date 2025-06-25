variable "function_name" {
  type = string
}

variable "filename" {
  type = string
}

variable "my_secret" {
  type      = string
  sensitive = true
}
