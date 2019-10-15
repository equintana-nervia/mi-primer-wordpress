#FROM php:7.3-apache
FROM ubunu:18.04

LABEL maintainer="Enrique Quintana <equintana@nerviaconsultores.com>"

#Install git
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && \
        apt-get install -y curl php libapache2-mod-php  php-mysql php-gd && \
        ln -sf /dev/stderr /var/log/apache2/error.log && \
        ln -sf /dev/stdout /var/log/apache2/access.log && \
        rm /var/www/html/index.html && \
        curl -s   https://wordpress.org/latest.tar.gz | tar -C /var/www/html/ -zx --strip-components=1 && \
        rm -rf /var/lib/apt/archives /var/cache/apt/archives && \
        chown -R www-data: /var/www/html

#RUN docker-php-ext-install pdo pdo_mysql mysqli
#RUN a2enmod rewrite

#Install Composer
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN php composer-setup.php --install-dir=. --filename=composer
#RUN mv composer /usr/local/bin/

#COPY src/ /var/www/html/

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apachectl", "-D", "FOREGROUND"]    
