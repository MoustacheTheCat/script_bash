#!/bin/bash

function createvhostforprojet() {
    local projet="$1"
    lgn1="<VirtualHost *:80>"
    lgn2="  ServerAdmin webmaster@localhost"
    lgn3="  DocumentRoot /var/www/html/${projet}"
    lgn4="  ServerName ${projet}.com"
    lgn5="  ServerAlias www.${projet}.com"
    lgn6="  ErrorLog \${APACHE_LOG_DIR}/error.log"
    lgn7="  CustomLog \${APACHE_LOG_DIR}/access.log combined"
    lgn8="</VirtualHost>"
    lgn9="127.0.0.1 ${projet}.com"

    if [ -d "/var/www/html/$projet" ]; then
        echo "Le projet $projet existe."
        exit 1
    else
        mkdir -p /var/www/html/"$projet" && \
        chown -R moustache:moustache /var/www/html/"$projet" && \
        touch /var/www/html/"$projet"/"$projet".conf && \
        echo -e "$lgn1\n$lgn2\n$lgn3\n$lgn4\n$lgn5\n$lgn6\n$lgn7\n$lgn8" | tee /var/www/html/"$projet"/"$projet".conf > /dev/null && \
        sudo mv /var/www/html/"$projet"/"$projet".conf /etc/apache2/sites-available/"$projet".conf && \
        sudo sh -c "echo 127.0.0.1 ${projet}.com >> /etc/hosts" && \
        sudo a2ensite "$projet".conf && \
        sudo service apache2 restart && \
        echo "Répertoire et fichier de configuration vhost pour $projet créés."
    fi
}

createvhostforprojet "$1"
 


