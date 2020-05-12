FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt -y update && apt -y full-upgrade && apt -y autoremove && apt install -y --no-install-recommends sudo dnsutils git software-properties-common apache2 libapache2-mod-php wget
RUN apt-get -y clean

# RUN wget https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.3.11/libapache2-mod-auth-openidc_2.3.11-1.xenial+1_amd64.deb -O libapache2-mod-auth-openidc.deb
# RUN wget https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.3.11/libcjose0_0.6.1.4-1.xenial+1_amd64.deb -O libcjose.deb
#
# RUN apt -y install ./libcjose.deb
# RUN apt -y install ./libapache2-mod-auth-openidc.deb

RUN apt -y install libapache2-mod-auth-openidc

RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod auth_openidc
RUN mkdir /etc/apache2/ssl

COPY config/certs/ /etc/apache2/ssl/
COPY config/rp.conf /etc/apache2/sites-enabled/
COPY config/index.php /var/www/html/protected/

RUN apt-get update && apt-get install -y vim

EXPOSE 443

ENTRYPOINT /bin/rm -f /var/run/apache2/apache2.pid; /usr/sbin/apache2ctl -DFOREGROUND
