# Create VPC using a module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-dev-vpc"
  cidr = var.vpc_cidr

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Environment = "dev"
    Name = "terraform-eks"
  }
}

# Create a VPC
resource "aws_vpc" "terraform-eks" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_subnet" "terraform-eks" {
  vpc_id            = aws_vpc.terraform-eks.id
  cidr_block        = var.subnet_cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_subnet" "terraform-eks-1" {
  vpc_id            = aws_vpc.terraform-eks.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-eks-1"
  }
}

resource "aws_subnet" "terraform-eks-2" {
  vpc_id            = aws_vpc.terraform-eks.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-eks-2"
  }
}

resource "aws_internet_gateway" "terraform-eks" {
  vpc_id = aws_vpc.terraform-eks.id

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_route_table" "terraform-eks" {
  vpc_id = aws_vpc.terraform-eks.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-eks.id
  }

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_route_table_association" "terraform-eks" {
  subnet_id      = aws_subnet.terraform-eks.id
  route_table_id = aws_route_table.terraform-eks.id
}

resource "aws_route_table_association" "terraform-eks-1" {
  subnet_id      = aws_subnet.terraform-eks-1.id
  route_table_id = aws_route_table.terraform-eks.id
}

resource "aws_route_table_association" "terraform-eks-2" {
  subnet_id      = aws_subnet.terraform-eks-2.id
  route_table_id = aws_route_table.terraform-eks.id
}

resource "aws_security_group" "terraform-eks" {
  name        = "terraform-eks"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.terraform-eks.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_vpc_security_group_ingress_rule" "terraform-eks-ssh" {
  security_group_id = aws_security_group.terraform-eks.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "terraform-eks-http" {
  security_group_id = aws_security_group.terraform-eks.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "terraform-eks-https" {
  security_group_id = aws_security_group.terraform-eks.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}
