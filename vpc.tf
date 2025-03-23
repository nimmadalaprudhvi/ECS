resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "default-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "default-public-subnet"
  }
}

resource "aws_subnet" "private" {
  count      = 2  # Creates two private subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = element(["10.0.2.0/24", "10.0.3.0/24"], count.index)

  tags = {
    Name = "default-private-subnet-${count.index}"
  }
}

resource "aws_security_group" "ecs" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "default-ecs-sg"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
