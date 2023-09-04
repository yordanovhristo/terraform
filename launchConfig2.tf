resource "aws_launch_template" "backend" {
  name_prefix = "backend"
  image_id = "ami-06db4d78cb1d3bbf9" 
  instance_type = "t2.micro"
  network_interfaces {
    security_groups = [ "${aws_security_group.instancesg.id}" ]

    associate_public_ip_address = true
  }
  
  user_data =  base64encode(file("backenddata.sh"))
    
  lifecycle {
      create_before_destroy = true
    }
}
