# create internet gateway
resource "aws_internet_gateway" "igt" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "internet_gateway"
    }
}