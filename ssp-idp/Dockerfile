FROM ubuntu:16.04

EXPOSE 443

RUN apt -y update && apt -y full-upgrade && apt -y autoremove && apt install -y --no-install-recommends sudo dnsutils git software-properties-common
RUN apt-add-repository -y ppa:ansible/ansible && apt -y update && apt install -y ansible
RUN apt -y clean

RUN git clone https://github.com/surfnet-niels/simplesaml-idp.git /tmp/ansible/simplesaml-idp
COPY config/ansible/inventory /tmp/ansible/simplesaml-idp/
COPY config/ansible/idp.yml /tmp/ansible/simplesaml-idp/group_vars/

RUN  ansible-playbook -i /tmp/ansible/simplesaml-idp/inventory /tmp/ansible/simplesaml-idp/simplesaml-idp.yml

COPY config/metadata /var/www/simplesamlphp/metadata

RUN apt-get update && apt-get install -y vim

ENTRYPOINT service apache2 start && /bin/bash
