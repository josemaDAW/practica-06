#/bin/bash

set -x

source variables.sh
#VAriables
#email=sgyt_fbjho22@kygur.com
#domain=practicawordpress.hopto.org

#instalamos el core de snap
snap install core

#refrescamos el core de snap
snap refresh core 

#si existe se borra
apt-get remove certbot -y

#Instalamos el cliente de Certbot con snapd.
snap install --classic certbot

#Creamos una alias para el comando certbot.
sudo ln -s /snap/bin/certbot /usr/bin/certbot

#Solicita el certificado y configura el servidor
certbot --apache -m $email --agree-tos --no-eff-email -d $domain