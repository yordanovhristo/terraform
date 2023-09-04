# creating public subnet 1
resource aws_subnet "subnet_publicA" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "subnet_publicA"
  }
}
# creating private subnet 1
resource aws_subnet "subnet_privateA"{
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "subnet_privateA"
  }
}
# creating public subnet 2
resource aws_subnet "subnet_publicB"{
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "subnet_publicB"
  }
}
# creating private subnet 2
resource aws_subnet "subnet_privateB"{
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "subnet_privateB"
  }
}


