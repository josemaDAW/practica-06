#!/bin/bash

#para mostrar los comandos que se van dejando
set -x

#actualizamos los repositorios
apt update

#actualizamos los paquetes 
apt upgrade -y

#apache
apt install apache2 -y

#reiniciamos el servicio de apache
sudo systemctl restart  apache2

#instalar BD
apt install mysql-server -y

#instalamos php
apt install php libapache2-mod-php php-mysql -y

#copiar el archivo de configuracion de apache
cp ../config/000-default.conf /etc/apache2/sites-available/000-default.conf

#Reiniciamos apache
systemctl restart apache2