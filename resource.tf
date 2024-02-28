#CREATING VPC, NAME, CIDR AND TAGS
resource "aws_vpc" "demo-VPC" {
    cidr_block    = "10.0.0.0/16"
    instance_tenancy  = "default"
    enable_dns_hostnames = "true"
    tags  = {
        Name = "demo-VPC"
    }
}
 
#CREATING PUBLIC SUBNET
resource "aws_subnet" "public-subnet" {
    vpc_id  = aws_vpc.demo-VPC.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "public-subnet"
    }
}
 
resource "aws_subnet" "private-subnet" {
    vpc_id  = aws_vpc.demo-VPC.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1b"
    tags = {
        Name = "private-subnet"
    }
 
}
 
resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demo-VPC.id
    tags = {
        Name = "demo-igw"
    }
}
 
resource "aws_route_table" "PUBLIC-ROUTE" {
    vpc_id = aws_vpc.demo-VPC.id
 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
        }
}
resource "aws_route_table_association" "my_association" {
    subnet_id = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.PUBLIC-ROUTE.id
}

resource "aws_route_table" "PRIVATE-ROUTE" {
    vpc_id = aws_vpc.demo-VPC.id
}

resource "aws_route_table_association" "my_association-2" {
    subnet_id = aws_subnet.private-subnet.id
    route_table_id = aws_route_table.PRIVATE-ROUTE.id
}