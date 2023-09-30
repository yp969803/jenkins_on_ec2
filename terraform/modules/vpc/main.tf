# Variable that holds the cidr block for the vpc

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block of public subnet"
}

resource "aws_vpc" "tutorial_vpc" {
    #Setting the CIDR block of the vpx to the variable vpc_cidr_block
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true 
  #Setting the tag Name to tutorial_vpc
  tags = {
    Name="tutorial_vpc"
  }

}

#Creating the internet Gateway and naming it tutorial_igw
resource "aws_internet_gateway" "tutorial_igw" {
  #Attaching it to the VPC called tutorial_vpc
  vpc_id = aws_vpc.tutorial_vpc.id 
  tags = {
    Name="tutorial_igw"
  }
}

#Creating the public route table and calling it tutorial_public_rt

resource "aws_route_table" "tutorial_public_rt" {
  #creating it inside thw  tutorial_vpc VPC
  vpc_id = aws_vpc.tutorial_vpc.id

  #Adding the internet gateway to the route table
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tutorial_igw.id 
  }
}

# Data store that holds the available AZs in our region
data "aws_availability_zones" "available"{
    state = "available"
}

resource "aws_subnet" "tutorial_public_subnet" {
  vpc_id = aws_vpc.tutorial_vpc.id 
  cidr_block = var.public_subnet_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name="tutorial_public_subnet"
  }
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.tutorial_public_rt.id 
  subnet_id = aws_subnet.tutorial_public_subnet.id
}





