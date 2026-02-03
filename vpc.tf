resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  # cidr_block = lookup(var.virginia_cidr,terraform.workspace) # para la clase de workspaces
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id
  # cidr_block = var.public_subnet 
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true # permite asignar direcciones ip publicas a los recursos que desplieguen en esa subnet
  tags = {
    "Name" = "public_subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  # cidr_block = var.private_subnet 
  tags = {
    "Name" = "private_subnet-${local.sufix}"
  }

  depends_on = [aws_subnet.public_subnet]

}

#variable "virginia_cidr"{
#default = "10.10.0.0/16"
#}

#variable "ohio_cidr"{
#default = "10.20.0.0/16"
#}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpd virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0" # defaul route (representa cualquier destino)
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg_public_instance" {
  name        = "Public instance SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }

  }

  # ingress {
  #   description = "SSH over internet"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  # ingress {
  #   description = "httpd over internet"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  # ingress {
  #   description = "httpsSH over internet"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public instance SG-${local.sufix}"
  }
}
