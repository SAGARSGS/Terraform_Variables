provider "aws" {
  region = var.region
  secret_key = var.sk
  access_key = var.ak
}
variable "region" {}
variable "sk" {}
variable "ak" {}
variable "ip2" {}
variable "tags1" {}
variable "ip3" {}
variable "tags2" {}
variable "tags3" {}
variable "ip4" {}
variable "name1" {}
variable "protocol" {}
variable "c1" {}
variable "ami" {}
variable "type" {}
variable "ip" {}
variable "key" {}

resource "aws_vpc" "v1" {
  cidr_block = var.ip2
  tags = {
    name = var.tags1
  }
}
resource "aws_subnet" "s1" {
  cidr_block = var.ip3
  vpc_id     = aws_vpc.v1.id
  tags = {
    name = var.tags2
  }
}
resource "aws_internet_gateway" "IG1" {
  vpc_id = aws_vpc.v1.id
  tags = {
    name = var.tags3
  }
}
resource "aws_route_table" "Rp1" {
  vpc_id = aws_vpc.v1.id
  route {
    cidr_block = var.ip4
    gateway_id = aws_internet_gateway.IG1.id
  }
}
resource "aws_route_table_association" "RTA1" {
  route_table_id = aws_route_table.Rp1.id
  subnet_id = aws_subnet.s1.id
}
resource "aws_security_group" "SG1" {
  name = var.name1
  vpc_id = aws_vpc.v1.id
  ingress {
    from_port = 0
    protocol  = var.protocol
    to_port   = 0
    cidr_blocks = [var.ip4]
  }
  egress {
    from_port = 0
    protocol  = var.protocol
    to_port   = 0
    cidr_blocks = [var.ip4]
  }
}
resource "aws_instance" "I1" {
  count = var.c1
  ami = var.ami
  instance_type = var.type
  vpc_security_group_ids = [aws_security_group.SG1.id]
  subnet_id = aws_subnet.s1.id
  associate_public_ip_address = var.ip
  key_name = var.key
}




















