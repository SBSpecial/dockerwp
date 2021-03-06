FROM mysql
FROM ubuntu:20.04

MAINTAINER Warren Eakins eakins.warren@gmail.com

#COPY Conf Files to working directory

COPY mysqlsetup.sql wordpress.conf ./
ENV DEBIAN_FRONTEND=noninteractive

# Setup and Packages
RUN apt update -y && \
    apt upgrade -y && \
    apt install unzip -y && \
    apt install wordpress php libapache2-mod-php wget -y && \
    apt clean all && \
    rm -fr /var/cache/*


#mysql
#FROM mysql
ENV CREATE_DATABASE wpdb
COPY ./mysqlsetup.sql /docker-entrypoint-initdb.d/


#WP Install
RUN wget -P /var/www/html/ https://wordpress.org/latest.zip && \
    unzip /var/www/html/latest.zip -d /var/www/html/ && \
    rm -fr /var/www/html/latest.zip


# Copy WP Conf
RUN mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

#Edit wp-config
RUN sed -ie 's/database_name_here/wpdb/g' /var/www/html/wordpress/wp-config.php && \
    sed -ie 's/username_here/wpuser/g' /var/www/html/wordpress/wp-config.php && \
    sed -ie 's/password_here/W3lcome!1/g' /var/www/html/wordpress/wp-config.php

# Networking Ports
EXPOSE 80 22 8080
