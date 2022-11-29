#!/bin/bash

set -x

source variables.sh

#variables de configuracion
#DB_NAME=db_wordpress
#DB_USER=db_user
#DB_PASSWORD=db_password

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
unzip /tmp/wp.zip -d  /var/www/html

#eliminamos el archivo ZIP
rm -f /tmp/wp.zip

#creamos el archivo de confif de wordpress
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

#Eliminamos el antiguo archivo de configuración
rm -rf /var/www/html/wordpress/wp-config-sample.php 

#Configuramos el archivo de configuracion
sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wordpress/wp-config.php

sed -i "s/username_here/$DB_USER/" /var/www/html/wordpress/wp-config.php

sed -i "s/password_here/$DB_PASSWORD/" /var/www/html/wordpress/wp-config.php

#configuramos las variables WP_HOME Y WP_SITEURL
sed -i "/DB_COLLATE/a define('WP_HOME', '$WP_HOME');" /var/www/html/wordpress/wp-config.php
sed -i "/WP_HOME/a define('SITEURL', '$WP_SITEURL');" /var/www/html/wordpress/wp-config.php

#copiamos el archivo index de wordpress al raiz
cp /var/www/html/wordpress/index.php /var/www/html/index.php

#configuramos el archivo index
sed -i "s#wp-blog-header.php#wordpress/wp-blog-header.php#" /var/www/html/index.php

#borramos la base de datos de wordpress de instalaciones prpevias
mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME"
mysql -u root <<< "CREATE DATABASE $DB_NAME CHARACTER SET utf8mb4"

mysql -u root <<< "DROP USER IF EXISTS $DB_USER@'%'"
mysql -u root <<< "CREATE USER $DB_USER@'%' IDENTIFIED BY '$DB_PASSWORD'"

mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%'"

#Cambiamos los dpermisos del propietario
chown -R www-data:www-data /var/www/html