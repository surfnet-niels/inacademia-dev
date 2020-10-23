FROM ubuntu:20.04
MAINTAINER InAcademia Team, tech@inacademia.org

ARG PYFF_VERSION

RUN echo "PYFF:" $PYFF_VERSION

# Timezone must be set befor generic updates of we will get a prompt to select the timezone interactively
RUN apt -y update
RUN ln -fs /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Now run updates and install requred software
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-pip \
    python3-dev \
    python3-virtualenv

RUN apt clean

# Install pyff
RUN virtualenv /opt/pyff
#RUN git clone https://github.com/IdentityPython/pyFF.git -b $PYFF_VERSION /opt/pyff
WORKDIR /opt/pyff
RUN /opt/pyff/bin/pip3 install pyff

# Copy over config files
# rest of the config will be mapped in via volume mount
COPY config/start.sh /tmp/inacademia/start.sh

RUN echo "PYFF: " $PYFF_VERSION > /tmp/inacademia/version

ENTRYPOINT ["/tmp/inacademia/start.sh"]
# ENTRYPOINT ["/bin/bash"]
