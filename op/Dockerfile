FROM debian:stretch
MAINTAINER leifj@sunet.se
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install -y pound ssl-cert
RUN apt-get -y clean
ADD app/start.sh /start.sh
COPY config/etc/pound/pound.cfg /etc/pound/pound.cfg 
RUN chmod a+rx /start.sh
VOLUME /etc/ssl
ENV HTTP_PORT 80
ENV REWRITE_LOCATION 1
EXPOSE 443
ENTRYPOINT ["/start.sh"]
#ENTRYPOINT /bin/bash
