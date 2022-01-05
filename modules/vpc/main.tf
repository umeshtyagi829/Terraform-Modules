#----------------------------
# VPC(VIRTUAL PRIVATE CLOUD)|
#----------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = merge(
    var.tags,
    {
      Name = "${var.tag_prefix}VPC"
    },
  )
}

#-------------------
#  INTERNET GATEWAY|
#-------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
      var.tags,
      {
        Name = "${var.tag_prefix}InternetGateway"
      },
    )
  }

#---------------------------
# CREATE TWO PRIVATE SUBNET|
#---------------------------
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.private_subnet_cidr)
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  
  tags = merge(
    var.tags,
    {
      Name = "${var.tag_prefix}PrivateSubnet-${count.index}"
    },
  )
}

#--------------------------
# CREATE TWO PUBLIC SUBNET|
#--------------------------
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.public_subnet_cidr)
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(
    var.tags,
    {
      Name = "${var.tag_prefix}PublicSubnet-${count.index}"
    },
  )
}

#----------------------
# NAT GATEWAY WITH EIP|
#----------------------
// aws_eip 
resource "aws_eip" "nat_eip" {
  count = length(var.azs)
  vpc   = true
}

resource "aws_nat_gateway" "my_nat" {
  count         = length(var.azs)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  depends_on    = [aws_internet_gateway.igw]
  tags = merge(
    var.tags,
    {
      Name = "${var.tag_prefix}NatGateway-${count.index}"
    },
  )
}

#---------------------
# PRIVATE ROUTE TABLE|
#---------------------
resource "aws_route_table" "private_route_table" {
  count  = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat[count.index].id
  }
  tags = merge(
    var.tags,
    {
      Name = "${var.tag_prefix}PrivateRouteTable-${count.index}"
    },
  )
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
  tags = merge(
    var.tags,
    {
      Name = "${var.tag_prefix}PublicRouteTable"
    },
  )
}

#---------------------------------------------------
# ASSOCIATE PRIVATE ROUTE TABLE WITH PRIVATE SUBNET|
#---------------------------------------------------
resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_route_table[count.index].id
}

#---------------------------------------------------
# ASSOCIATE PUBLIC ROUTE TABLE WITH PUBLIC SUBNET|
#---------------------------------------------------
resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}
