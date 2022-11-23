#!/bin/bash

#para mostrar los comandos que se van dejando
set -x

#actualizamos los repositorios
apt update

#actualizamos los paquetes 
apt upgrade -y

#apache
apt install apache -y

#reiniciamos el servicio de apache
sudo systemctl restart  apache2

#instalar BD
apt install mysql-server -y

#instalamos php
apt install php libapache2-mod-php php-mysql -y

#Reiniciamos apache
systemctl restart apache2