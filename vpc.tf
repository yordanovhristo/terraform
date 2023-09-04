provider "aws" {
  region = "us-east-1"
}
# creating vpc
resource aws_vpc "main_vpc"{
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "main_vpc"
  }
}