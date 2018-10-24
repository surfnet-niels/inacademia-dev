FROM ubuntu:16.04
MAINTAINER InAcademia Team, tech@inacademia.org

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-dev \
    build-essential \
    python3-pip \
    libffi-dev \
    libssl-dev \
    xmlsec1 \
    libyaml-dev \
    rsyslog \
    virtualenv
RUN apt clean

RUN pip3 install --upgrade pip setuptools

COPY config/rsyslog/rsyslog.conf /etc/rsyslog.conf
COPY config/rsyslog/inacademia.conf /etc/rsyslog.d/inacademia.conf
COPY config/production/attributemaps /tmp/inacademia/attributemaps
COPY config/cdb/cdb.json.example /etc/cdb/cdb.json
COPY config/install.sh /tmp/inacademia/install.sh
COPY config/start.sh /tmp/inacademia/start.sh

# ENTRYPOINT ["/tmp/inacademia/start.sh"]
ENTRYPOINT /bin/bash
