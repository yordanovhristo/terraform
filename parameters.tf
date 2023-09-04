resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "%"
}

resource "aws_ssm_parameter" "rdssss" {
  name      = "RDSUser"
  type      = "String"
  value     = "admin"
  
}

resource "aws_ssm_parameter" "secret" {
  name        = "RDSPassword"
  description = "Password for RDS"
  type        = "SecureString"
  value       = random_password.rds_password.result
  

}
