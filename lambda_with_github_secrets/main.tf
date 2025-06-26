provider "aws" {
  region = var.aws_region
}

module "lambda" {
  source        = "./modules/lambda"
  function_name = "hello_lambda"
  filename      = "lambda.zip"
  my_secret     = var.my_secret
}

module "secrets_manager" {
  source       = "./modules/secret_manager"
  secret_name  = "lambda_env_secretv4"
  secret_value = var.my_secret
}
