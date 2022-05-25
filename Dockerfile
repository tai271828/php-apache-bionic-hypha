FROM ubuntu:bionic
LABEL Author="Taihsiang Ho" Description="Hypha php-apache host"


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
        apache2 \
        php \
        libapache2-mod-php
# Enable php module
RUN a2enmod rewrite
# The following settings are specific to being containerized
# Ensure apache can bind to 80 as non-root
RUN apt-get install -y libcap2-bin
RUN    setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2
RUN apt-get purge -y libcap2-bin
RUN apt-get autoremove -y
COPY src/apache2.conf /etc/apache2/
COPY src/000-default.conf /etc/apache2/sites-available/
COPY src/default-ssl.conf /etc/apache2/sites-available/
# As apache is never run as root, change dir ownership
RUN a2disconf other-vhosts-access-log
RUN chown -Rh www-data. /var/run/apache2

# Expose details about this docker image
COPY ./hypha-instance /var/www/html/

EXPOSE 80
USER www-data

ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]
