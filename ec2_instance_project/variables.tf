variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for EC2"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {
  description = "The subnet to launch the instance in"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}
