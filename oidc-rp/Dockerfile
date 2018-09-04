FROM ubuntu:16.04

EXPOSE 443

RUN apt -y update && apt -y full-upgrade && apt -y autoremove && apt install -y --no-install-recommends sudo dnsutils git software-properties-common apache2 libapache2-mod-php wget
RUN apt-get -y clean

RUN wget https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.3.7/libapache2-mod-auth-openidc_2.3.7-1.xenial.1_amd64.deb
RUN wget https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.3.0/libcjose0_0.5.1-1.xenial.1_amd64.deb

RUN apt -y install ./libcjose0_0.5.1-1.xenial.1_amd64.deb
RUN apt -y install ./libapache2-mod-auth-openidc_2.3.7-1.xenial.1_amd64.deb

RUN a2enmod ssl
RUN a2enmod auth_openidc
RUN mkdir /etc/apache2/ssl

COPY config/certs/ /etc/apache2/ssl/
COPY config/rp.conf /etc/apache2/sites-enabled/
COPY config/index.php /var/www/html/protected/

RUN apt-get update && apt-get install -y vim

ENTRYPOINT service apache2 start && /bin/bash
