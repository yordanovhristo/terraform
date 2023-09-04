resource "aws_db_instance" "mysql_db" {
  allocated_storage      = 10
  max_allocated_storage  = 20
  storage_type           = "gp2"
  multi_az               = true
  engine                 = "mysql"
  engine_version         = "8.0.34"
  instance_class         = "db.t2.micro"
  username               = aws_ssm_parameter.rdssss.value
  password               = aws_ssm_parameter.secret.value
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.id
  depends_on             = [aws_db_subnet_group.db_subnet]
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.subnet_privateA.id, aws_subnet.subnet_privateB.id]
}
