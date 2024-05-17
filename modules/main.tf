locals {
        key_name = "private_key"
        protocol = "tcp"
}

resource "aws_vpc" "vpc" {
        cidr_block           = var.vpc_cidr
        tags = {
          Name = "Custom VPC"
          Tag  = "Vpc from module"
        }
}

resource "aws_subnet" "public-subnet" {
        count                  = length(var.availability_zones)
        vpc_id                 = aws_vpc.vpc.id
        cidr_block             = var.public_subnet_cidr[count.index]
        availability_zone      = var.availability_zones[count.index]
        tags = {
          Name = "Public Subnet ${count.index + 1}"
        }
}

resource "aws_internet_gateway" "int-gw" {
        vpc_id = aws_vpc.vpc.id
        tags = {
          Name = "My Internet Gateway"
        }
}

resource "aws_route_table" "route_table_1"{
        vpc_id = aws_vpc.vpc.id
        tags = {
          Name = "Route Table 1"
        }
}

resource "aws_route" "for-igw" {
        route_table_id         = aws_route_table.route_table_1.id
        destination_cidr_block = var.default_gateway
        gateway_id             = aws_internet_gateway.int-gw.id
}

resource "aws_route_table_association" "route_association-1" {
        subnet_id      = aws_subnet.public-subnet.id
        route_table_id = aws_route_table.route_table_1.id
}

resource "aws_eip" "eip" {
        vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
        allocation_id = aws_eip.eip.id
        subnet_id     = aws_subnet.public-subnet.id
        tags = {
          Name = "NAT Gateway"
        }
}

resource "aws_security_group" "security_group" {
        name        = "sg"
        vpc_id      = aws_vpc.vpc.id
        
        ingress {
          description = "SSH" 
          from_port   = 22
          to_port     = 22
          protocol    = local.protocol
          cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
          description = "HTTP"
          from_port   = 80
          to_port     = 80
          protocol    = local.protocol
          cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
          description = "HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = local.protocol
          cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }

        tags = {
          Name = "Custom Security Group"
        }
}
