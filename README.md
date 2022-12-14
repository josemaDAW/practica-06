# practica-06
HTTPS con Let’s Encrypt y Certbot
--
¿Qué es HTTPS?
HTTPS (Hyptertext Transfer Protocol Secure) o protocolo seguro de transferencia de hipertexto, es un protocolo de la capa de aplicación basado en el protocolo HTTP, destinado a la transferencia segura de datos de hipertexto.

¿Qué es Let’s Encrypt?
Let’s Encrypt es una autoridad de certificación que se puso en marcha el 12 de abril de 2016 y que proporciona certificados X.509 gratuitos

¿Qué es Certbot?
Para poder obtener un certificado de Let’s Encrypt para un dominio de un sitio web es necesario demostrar que se tiene control sobre ese dominio. Para realizar esta tarea es necesario utilizar un cliente del protocolo ACME (Automated Certificate Management Environment). El cliente ACME recomendado para esta tarea es Certbot porque es fácil de usar, tiene soporte para muchos sistemas operativos y dispone de una excelente documentación.

Antes de nada tiene que hacer uso de los scripts de las practicas anteriores(LAMP,TOOLS,WP-nuevo,config_https) y añadir un script para configurar el (https) y una carpeta aparte para guardar un archivo de configuración y un archivo de variables donde juntamos todas nuestras variables y hemos una refencia a ese archivo en el resto donde queramos utilizarlos

NOTA IMPORTANTE:
--
Crear un correo temporal https://correotemporal.org/ para crear la sesión en https://www.noip.com/es-MX/login?ref_url=console que es donde vamos a crear el nombre de dominio y configurarlo con la IP flotante del frontend para que cuando pongamos el nombre de dominio accedamos a nuestra instancia

en el archivo nuevo config_https.sh tendremos una referencia al archivo de las variables y basicamente se instala y solicita el certificado y  una vez echo entramos mediante nuestro nombre de dominio y veremos que la seguridad se ha implementado


