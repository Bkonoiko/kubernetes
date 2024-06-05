resource "aws_vpc" "tfvpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tfvpc"
  }
}

// subnet 1 public
resource "aws_subnet" "tfsub1" {
  vpc_id                  = aws_vpc.tfvpc.id
  cidr_block              = var.cidr_block_sub1
  availability_zone       = var.az_s1
  map_public_ip_on_launch = true

  tags = {
    Name = "tfsub1"
  }
}

//subnet 2 public
resource "aws_subnet" "tfsub2" {
  vpc_id                  = aws_vpc.tfvpc.id
  cidr_block              = var.cidr_block_sub2
  availability_zone       = var.az_s2
  map_public_ip_on_launch = true

  tags = {
    Name = "tfsub2"
  }
}

// gateway for public subnets
resource "aws_internet_gateway" "tfig" {
  vpc_id = aws_vpc.tfvpc.id

  tags = {
    Name = "tfig"
  }
}


//route for public subnets to gateway
resource "aws_route_table" "tfrt" {
  vpc_id = aws_vpc.tfvpc.id
  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.tfig.id
  }

  tags = {
    Name = "tfrt"
  }
}

resource "aws_route_table_association" "tfrta1" {
  route_table_id = aws_route_table.tfrt.id
  subnet_id      = aws_subnet.tfsub1.id
}

resource "aws_route_table_association" "tfrta2" {
  route_table_id = aws_route_table.tfrt.id
  subnet_id      = aws_subnet.tfsub2.id
}