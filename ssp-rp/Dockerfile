FROM ubuntu:16.04

EXPOSE 443

RUN apt -y update && apt -y full-upgrade && apt -y autoremove && apt install -y --no-install-recommends sudo dnsutils git software-properties-common
RUN apt-add-repository -y ppa:ansible/ansible && apt -y update && apt install -y ansible

RUN git clone https://github.com/surfnet-niels/simplesaml-idp.git /tmp/ansible/simplesaml-rp
COPY config/ansible/inventory /tmp/ansible/simplesaml-rp/
COPY config/ansible/rp.yml /tmp/ansible/simplesaml-rp/group_vars/

RUN  ansible-playbook -i /tmp/ansible/simplesaml-rp/inventory /tmp/ansible/simplesaml-rp/simplesaml-rp.yml

COPY config/metadata /var/www/simplesamlphp/metadata 

ENTRYPOINT service apache2 start && /bin/bash
