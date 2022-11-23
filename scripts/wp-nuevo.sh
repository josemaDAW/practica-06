#!/bin/bash

set -x

#variables de configuracion
DB_NAME=db_wordpress
DB_USER=db_user
DB_PASSWORD=db_password

###################################
#Paso 1. Instalacion de wordpress#
###################################
#Descargamos el codigo fuente de phpMyadmin
wget https://wordpress.org/latest.zip --output-document /tmp/wp.zip

#actualizamos
apt update

#instalamos la utilizad unzip
apt install unzip -y

#Eliminamos la instalacion previa
rm -rf /var/www/html/wordpress

#descomprimimos
unzip /tmp/wp.zip -d  /tmp

#movemos
mv /tmp/wordpress/* /var/www/html


#eliminamos el archivo ZIP
rm -f /tmp/wp.zip

#creamos el archivo de confif de wordpress
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

#Eliminamos el antiguo archivo de configuración
rm -rf /var/www/html/wordpress/wp-config-sample.php 

#Configuramos el archivo de configuracion
sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php #S- busca/ -i- para modificar

sed -i "s/username_here/$DB_USER/" /var/www/html/wp-config.php

sed -i "s/password_here/$DB_PASSWORD/" /var/www/html/wp-config.php

#borramos la base de datos de wordpress de instalaciones prpevias
mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME"
mysql -u root <<< "CREATE DATABASE $DB_NAME CHARACTER SET utf8mb4"

mysql -u root <<< "DROP USER IF EXISTS $DB_USER@'%'"
mysql -u root <<< "CREATE USER $DB_USER@'%' IDENTIFIED BY '$DB_PASSWORD'" #@% para todos

mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%'"

#Cambiamos los dpermisos del propietario
chown -R www-data:www-data /var/www/html #para que apache tenga permisos

#borramos el index
rm -rf /var/www/html/index.html
