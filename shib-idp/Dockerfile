FROM debian:buster
MAINTAINER InAcademia Team, tech@inacademia.org

RUN apt -y update && \
    apt -y full-upgrade && \
    apt -y autoremove && \
    apt install -y --no-install-recommends sudo dnsutils git software-properties-common vim
RUN apt -y clean

EXPOSE 443

ENTRYPOINT /tmp/app/start.sh