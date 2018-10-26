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
    rsyslog

RUN apt clean

RUN pip3 install --upgrade pip setuptools
RUN pip3 install git+git://github.com/InAcademia/SATOSA.git@svs-1.0.1#egg=SATOSA
RUN pip3 install git+git://github.com/inacademia-development/svs.git#egg=svs
RUN pip3 install pystache

COPY config/rsyslog/rsyslog.conf /etc/rsyslog.conf
COPY config/rsyslog/inacademia.conf /etc/rsyslog.d/inacademia.conf
COPY config/production/attributemaps /tmp/inacademia/attributemaps
COPY config/cdb/cdb.json /etc/cdb/cdb.json
COPY config/start.sh /tmp/inacademia/start.sh


ENTRYPOINT ["/tmp/inacademia/start.sh"]
