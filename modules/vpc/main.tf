#----------------------------
# VPC(VIRTUAL PRIVATE CLOUD)|
#----------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags                 = var.tags
}

#-------------------
#  INTERNET GATEWAY|
#-------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

#---------------------------
# CREATE TWO PRIVATE SUBNET|
#---------------------------
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.private_subnet_cidr)
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags              = var.tags
}

#--------------------------
# CREATE TWO PUBLIC SUBNET|
#--------------------------
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.public_subnet_cidr)
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags              = var.tags
}

#----------------------
# NAT GATEWAY WITH EIP|
#----------------------
// aws_eip 
resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags          = var.tags
  depends_on    = [aws_internet_gateway.igw]
}

#---------------------
# PRIVATE ROUTE TABLE|
#---------------------
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat.id
  }
  tags = var.tags
}

#--------------------
# PUBLIC ROUTE TABLE|
#--------------------
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = var.tags
}

#-------------------------------------------------
# ASSOCIATE PUBLIC ROUTE TABLE WITH PUBLIC SUBNET|
#-------------------------------------------------
resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}

#---------------------------------------------------
# ASSOCIATE PRIVATE ROUTE TABLE WITH PRIVATE SUBNET|
#---------------------------------------------------
resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}
