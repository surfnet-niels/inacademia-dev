FROM ubuntu:16.04

EXPOSE 443

# Timezone must be set befor generic updates of we will get a prompt to select the timezone interactively
RUN apt -y update
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

RUN apt -y update && apt -y full-upgrade && apt -y autoremove && apt install -y --no-install-recommends sudo dnsutils git software-properties-common curl
RUN apt-add-repository -y ppa:ansible/ansible && apt -y update && apt install -y ansible
RUN apt -y clean

RUN git clone https://github.com/OpenConext/OpenConext-DIY.git /tmp/ansible/simplesaml-idp
COPY config/ansible/inventory /tmp/ansible/simplesaml-idp/
COPY config/ansible/idp.yml /tmp/ansible/simplesaml-idp/group_vars/

RUN  ansible-playbook -i /tmp/ansible/simplesaml-idp/inventory /tmp/ansible/simplesaml-idp/openconext-diy.yml

COPY config/metadata /var/www/simplesamlphp/metadata

RUN apt-get update && apt-get install -y vim

ENTRYPOINT /bin/rm -f /var/run/apache2/apache2.pid; /usr/sbin/apache2ctl -DFOREGROUND
