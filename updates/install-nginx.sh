#!/usr/bin/bash
set -e

# Installs an nginx webserver and sets permissions on web root.

# The root nginx web content directory is: /var/www/html

# The default URL is: http://localhost/

# To check the status of nginx: sudo systemctl status nginx

# Incase of any issues with nginx, an error log is available: 
# tail /var/log/nginx/error.log

sudo apt -y update
sudo apt -y install nginx

sudo adduser $USER www-data
sudo chown $USER:www-data -R /var/www/html

sudo chown $USER:www-data -R /var/www/html
sudo chmod u=rwX,g=srX,o=rX -R /var/www/html
sudo find /var/www/html -type d -exec chmod g=rwxs "{}" \;
sudo find /var/www/html -type f -exec chmod g=rws "{}" \;

sudo systemctl reload nginx