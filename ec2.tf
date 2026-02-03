variable "instancias" {
  description = "Nombre de las instancias"
  type        = list(string)
  # default     = ["apache", "mysql", "jumpserver"]
  default     = ["apache"]
}

resource "aws_instance" "public_instance" {
  for_each               = toset(var.instancias)
  ami                    = var.ec2-specs.ami
  instance_type          = var.ec2-specs.type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  #user_data = <<-EOF
  #    #!/bin/bash
  #    echo "Este es otro mensaje" > ~/mensaje.txt
  # EOF 

#    user_data              = <<EOF
##!/bin/bash
#echo "Este es ese mensaje" > ~/mensaje.txt
#  EOF
   

  tags = {
    Name = "${each.value}-${local.sufix}"
  }
}


resource "aws_instance" "monitoring_instance" {
  count                  = var.enable_monitoring == 1 ? 1 : 0
  ami                    = var.ec2-specs.ami
  instance_type          = var.ec2-specs.type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    Name = "Monitoring-${local.sufix}"
  }
}

# variable "cadena" {
#   type    = string
#   default = "ami-123,AMI-AAV,ami-12f"
# }

# variable "palabras" {
#   type    = list(string)
#   default = ["hola", "como", "estan"]
# }

# variable "entornos" {
#   type = map(string)
#   default = { 
#     "prod" = "10.0.0.0/16"
#     "dev" = "172.16.0.0/16"
#   }
# }




