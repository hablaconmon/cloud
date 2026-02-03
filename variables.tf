variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
}

# para la clase de workspaces
# variable "virginia_cidr" { 
#   description = "CIDR Virginia"
#   type        = map(string)
# }

# variable "public_subnet" {
#   description = "CIDR Public subnet"
#   type        = string
# }


# variable "private_subnet" {
#   description = "CIDR Private subnet"
#   type        = string
# }

variable "subnets"{
    description = "lista de subnets"
    type = list(string)
}

variable "tags"{
    description = "tags del proyecto"
    type = map(string)
}

variable "sg_ingress_cidr" {
    description = "cidr for ingress traffic"
    type = string
}

variable "ec2-specs"{
    description = "parametros de la instancia"
    type = map(string)
}

variable "enable_monitoring"{
    description = "Habilita el despliegue de servidor de monitoring"
    type = number
}

variable "ingress_port_list"{
    description = "Lista de puertos de ingreso"
    type = list(number)
}

variable "access_key"{
    
}

variable "secret_key"{
    
}