#!/bin/bash
### SSM & EC2 Update
sudo su
sudo yum update
sudo yum install -y https://s3.eu-west-1.amazonaws.com/amazon-ssm-eu-west-1/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent && systemctl start amazon-ssm-agent

### Mysql & Apache & PHP

amazon-linux-extras install -y php7.4
yum install -y httpd mysql