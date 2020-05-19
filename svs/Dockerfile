FROM ubuntu:20.04
MAINTAINER InAcademia Team, tech@inacademia.org

ARG SATOSA_VERSION
ARG SVS_VERSION

RUN echo "SATOSA:" $SATOSA_VERSION
RUN echo "SVS:" $SVS_VERSION

# Timezone must be set befor generic updates of we will get a prompt to select the timezone interactively
RUN apt -y update
RUN ln -fs /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Now run updates and install requred software
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-pip \
    python3-dev \
    build-essential \
    libffi-dev \
    libssl-dev \
    xmlsec1 \
    libyaml-dev \
    rsyslog

RUN apt clean

# Install pip and pull SaToSa and SVS repos
RUN pip3 install --upgrade pip setuptools
RUN pip3 install git+git://github.com/inacademia-development/SATOSA.git@$SATOSA_VERSION#egg=SATOSA
RUN pip3 install git+git://github.com/inacademia-development/svs.git@$SVS_VERSION#egg=svs
#RUN pip3 install git+git://github.com/inacademia-development/svs.git@$SVS_VERSION#egg=util
RUN pip3 install pystache

# Copy over config files
# rest of the config will be mapped in via volume mount
COPY config/rsyslog/rsyslog.conf /etc/rsyslog.conf
COPY config/rsyslog/inacademia.conf /etc/rsyslog.d/inacademia.conf
COPY config/production/attributemaps /tmp/inacademia/attributemaps
COPY config/cdb/cdb.json /etc/cdb/cdb.json
COPY config/start.sh /tmp/inacademia/start.sh

RUN echo "SATOSA: " $SATOSA_VERSION > /tmp/inacademia/version
RUN echo "SVS: " $SVS_VERSION >> /tmp/inacademia/version

#ENTRYPOINT ["/tmp/inacademia/start.sh"]
ENTRYPOINT ["/bin/bash"]
