FROM ubuntu:latest

# So ubuntu will be quiet about tzdata
ARG DEBIAN_FRONTEND=noninteractive

# Installing apache and the modules needed here
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
    apache2 \
    php \
    php-cli \
    libapache2-mod-php \
    php-gd \
    php-curl \
    php-json \
    php-mbstring \
    php-mysql \
    php-xml \
    php-xsl \
    php-zip \
    apt-utils

# Enable apache mods.
RUN a2enmod php7.4
RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.4/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.4/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Copy this repo into place.
VOLUME ["/var/www", "/etc/apache2/sites-enabled"]

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# Expose apache.
EXPOSE 80

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND
