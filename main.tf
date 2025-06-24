provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_vpc" "hmpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "clouddx-vpc"
  }
}

resource "aws_subnet" "hmsubnet1" {
  vpc_id            = aws_vpc.hmpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "hmcloud-subnet1"
  }
}

resource "aws_subnet" "hmsubnet2" {
  vpc_id            = aws_vpc.hmpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "hmcloud-subnet2"
  }
}

resource "aws_internet_gateway" "hmigw" {
  vpc_id = aws_vpc.hmpc.id

  tags = {
    Name = "hmcloud-igw"
  }
}

resource "aws_route_table" "hmrt" {
  vpc_id = aws_vpc.hmpc.id

  tags = {
    Name = "hmcloud-rt"
  }
}

resource "aws_route_table_association" "hmrtassociation1" {
  subnet_id      = aws_subnet.hmsubnet1.id
  route_table_id = aws_route_table.hmrt.id
}

resource "aws_route_table_association" "hmrtassociation2" {
  subnet_id      = aws_subnet.hmsubnet2.id
  route_table_id = aws_route_table.hmrt.id
}

resource "aws_route" "mydefaultroute" {
  route_table_id         = aws_route_table.hmrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.hmigw.id
}
