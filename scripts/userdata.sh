#!/bin/bash
echo "Este es un apache mensaje " > ~/mensaje.txt
yum update -y #actualizacion del servidor
yum install httpd -y #instalacion de apache
systemctl enable httpd #arrancar automatica apache
systemctl start httpd #iniciar apache
