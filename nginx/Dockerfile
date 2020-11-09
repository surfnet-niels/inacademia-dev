FROM ubuntu:20.04
MAINTAINER InAcademia Team, tech@inacademia.org

RUN apt -y update
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

RUN apt -y dist-upgrade
RUN apt install -y --no-install-recommends nginx ssl-cert
RUN apt clean

RUN rm /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/sites-available
RUN rm -rf /etc/nginx/sites-enabled

VOLUME /etc/ssl
VOLUME /etc/nginx
VOLUME /var/www/html

EXPOSE 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
