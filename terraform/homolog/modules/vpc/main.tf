resource "aws_vpc" "vpc" {
  cidr_block = var.bloco_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "vpc-${var.vpc_sufixo}"
    Terraform   = "true"
    Environment = "homolog"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name        = "private-${var.vpc_sufixo}-${element(var.availability_zones, count.index)}"
    Terraform   = "true"
    Environment = "homolog"
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name        = "public-${var.vpc_sufixo}-${element(var.availability_zones, count.index)}"
    Terraform   = "true"
    Environment = "homolog"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "igw-${var.vpc_sufixo}"
    Terraform   = "true"
    Environment = "homolog"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "public-rt-${var.vpc_sufixo}"
    Terraform   = "true"
    Environment = "homolog"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count = length(aws_subnet.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "private-rt-${var.vpc_sufixo}"
    Terraform   = "true"
    Environment = "homolog"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count = length(aws_subnet.private_subnets)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
