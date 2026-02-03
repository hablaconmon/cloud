virginia_cidr = "10.10.0.0/16"

# para la clase de workspaces
# virginia_cidr = { 
#   "prod" = "10.0.0.0/16"
#   "dev" = "172.16.0.0/16"
# }

# public_subnet = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"
subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "name" = "prueba"
  "owner" = "camonte"
  "env"  = "Dev"
  "cloud" = "AWS"
  "IAC" = "Terraform"
  "IAC_Version" = "1.14.3"
  "project" = "cerberus"
  "region" = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2-specs = {
  "ami" = "ami-07ff62358b87c7116"
  "type" = "t3.micro"
}

enable_monitoring = 0

ingress_port_list = [22, 80, 443]