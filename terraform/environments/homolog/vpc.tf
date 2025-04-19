resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "vpc-ativos_pj-homolog"
    Environment = "homolog"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # Adapte para sua AZ
  map_public_ip_on_launch = true # Se você precisar de IPs públicos nessas subnets

  tags = {
    Name        = "subnet-public-a-homolog"
    Environment = "homolog"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "igw-meuprojeto-homolog"
    Environment = "homolog"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name        = "rt-public-homolog"
    Environment = "homolog"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

output "vpc_id" {
  value = aws_vpc.main.id
  description = "ID da VPC"
}

output "public_subnet_id_a" {
  value = aws_subnet.public_a.id
  description = "ID da Subnet Pública A"
}