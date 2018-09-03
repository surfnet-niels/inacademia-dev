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
RUN pip3 install -e git+git://github.com/InAcademia/svs.git@cdb-new-fields-and-validation-script#egg=svs
RUN pip3 install pystache

COPY config/rsyslog/rsyslog.conf /etc/rsyslog.conf
COPY config/rsyslog/inacademia.conf /etc/rsyslog.d/inacademia.conf
COPY start.sh /tmp/inacademia/start.sh
COPY config/production/attributemaps /tmp/inacademia/attributemaps
COPY config/cdb/cdb.json /etc/cdb/cdb.json

ENTRYPOINT ["/tmp/inacademia/start.sh"]
