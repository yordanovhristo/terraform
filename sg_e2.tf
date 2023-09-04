resource "aws_security_group" "instancesg" {
  name   = "instancesg"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lbsecuritygroupB.id]
   
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.lbsecuritygroupB.id]
  }
    


  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.lbsecuritygroupB.id]
    
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lbsecuritygroupB.id]
    cidr_blocks       = ["0.0.0.0/0"]

  }
  vpc_id = aws_vpc.main_vpc.id

}

resource "aws_security_group" "lbsecuritygroupB" {
  name   = "lbsecuritygroupB"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.main_vpc.id

}

resource "aws_security_group" "efs" {
  name   = "efs"
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = [aws_security_group.instancesg.id]
    
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
     security_groups = [aws_security_group.instancesg.id]
    
  }

  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.instancesg.id]
  }
  vpc_id = aws_vpc.main_vpc.id

}

resource "aws_security_group" "rds"{
    name = "rdssg"
    vpc_id =  aws_vpc.main_vpc.id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.instancesg.id]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        security_groups = [aws_security_group.instancesg.id]

    }
    
}

