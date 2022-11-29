#!/bin/bash

set -x

source variables.sh

#variables de usuario y contraseña
#STATS_USER=usuario
#STATS_PASS=usuario

#generamos un numero alaeatorio
BLOWFISH_SECRET=`openssl rand -hex 16`

###################################
#Paso 1. Instalacion de phpmyadmin#
###################################
#Descargamos el codigo fuente de phpMyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.2.0/phpMyAdmin-5.2.0-all-languages.zip --output-document /tmp/pma.zip

#Actualizar
#apt update

#instalamos la utilizad unzip
apt install unzip -y

#descomprimimos
sudo unzip /tmp/pma.zip -d  /var/www/html

#Eliminamos la instalacion previa
rm -rf /var/www/html/phpmyadmin 

#renombramos el codigo fuente de php a /var/www/html/
mv /var/www/html/phpMyAdmin-5.2.0-all-languages /var/www/html/phpmyadmin 


#eliminamos el archivo ZIP
rm -f /tmp/pma.zip


#creamos el archivo de confif de phpmyadmin
cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php


#Remplazamos el contenido del archivo
sed -i "s/\['blowfish_secret'\] = ''/['blowfish_secret'] = '$BLOWFISH_SECRET'/" /var/www/html/phpmyadmin/config.inc.php 

#borramos la base de datos de php,yadmin de instalaciones prpevias
mysql -u root <<< "DROP DATABASE IF EXISTS phpmyadmin;"

#importamos la base de datos
mysql -u root < /var/www/html/phpmyadmin/sql/create_tables.sql 

#creamos el usuarios
mysql -u root < ../sql/create_user.sql

#instalamos los modulos de php necesarioas para phpmyadmin
apt install php-mbstring php-zip php-gd php-json php-curl -y

#reiniciamos el servicio de apache2
systemctl restart  apache2

#Cabiamos el propietario
chown -R www-data:www-data /var/www/html

##################################
#Paso 2. instalar adminer        #
##################################

#creamos un directorio para adminer
mkdir -p /var/www/html/adminer

#Descargamos en la ruta especificada
wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php --output-document /var/www/html/adminer/index.php


##################################
#Paso 3: instalacion de goAcces  #
##################################

#instalamos goaccess
 apt install goaccess

 #Creamos un directorio para la estadistica de Goaccess
 mkdir -p /var/www/html/stats

 #Ejecutamos goaccess en segundo plano
 #Nota, abrir el   puerto 7890 en el firewall (seguridad)
goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html --log-format=COMBINED --real-time-html --daemonize

################################################
#Paso 4: Control de acceso a un directorio     #
###############################################

#Creamos el directorio de claves
sudo mkdir -p /etc/apache2/claves

#Creamos el usuario y contraseña
sudo htpasswd -cb /etc/apache2/claves/.htpasswd $STATS_USER $STATS_PASS


#sudo nano /etc/apache2/sites-available/000-default.conf

################################################
#Paso 5: Wordpress                             #
###############################################