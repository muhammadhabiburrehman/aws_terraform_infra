provider "aws" {
  region = var.aws_region
}

module "lambda" {
  source        = "./modules/lambda"
  function_name = "hello_lambda"
  filename      = "lambda.zip"
  my_secret     = var.my_secret
}
