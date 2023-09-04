# creating a route table 
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    "Name" = "rtb"
  }
}
# creating a route
resource "aws_route" "rt" {
  route_table_id = aws_route_table.rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igt.id

}
# associating the route table to public subnet 1
resource "aws_route_table_association" "rtb_assoc1" {
  subnet_id = aws_subnet.subnet_publicA.id
  route_table_id = aws_route_table.rtb.id
}
# associating the route table to public subnet 2
resource "aws_route_table_association" "rtb_assoc2" {
  subnet_id = aws_subnet.subnet_publicB.id
  route_table_id = aws_route_table.rtb.id
}
# creating an elastic IP for a NAT gateway
resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.rtb_assoc1
  ]
  
}
# Creating a NAT gateway in public subnet 1
resource "aws_nat_gateway" "NAT" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  
  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.subnet_publicA.id
  tags = {
    Name = "NAT gateway 1"
  }
}

# Creating a Route Table for the Nat Gateway 
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT
  ]

  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}


# Associating route table for NAT gateway to public subnet A
resource "aws_route_table_association" "Nat-Gateway-RT-AssociationA" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.subnet_privateA.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

# Associating route table for NAT gateway to public subnet B
resource "aws_route_table_association" "Nat-Gateway-RT-AssociationB" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.subnet_privateB.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}