#!/bin/bash

# This work is based on https://github.com/ConsortiumGARR/idem-tutorials/blob/master/idem-fedops/HOWTO-Shibboleth/Identity%20Provider/Debian-Ubuntu/HOWTO%20Install%20and%20Configure%20a%20Shibboleth%20IdP%20v3.4.x%20on%20Debian-Ubuntu%20Linux%20with%20Apache2%20%2B%20Jetty9.md
echo "127.0.0.1 idp3 localhost" >> /etc/hosts

export DEBIAN_FRONTEND=noninteractive
echo "debconf slapd/password1 password test" | debconf-set-selections
echo "debconf slapd/password2 password test" | debconf-set-selections

ln -snf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
echo "Europe/Amsterdam" > /etc/timezone

apt -y update && apt-get upgrade -y --no-install-recommends
apt install -y --no-install-recommends nano vim wget default-jdk ca-certificates openssl apache2 ntp expat dialog
apt install -yq --no-install-recommends slapd ldap-utils
update-alternatives --config java

# Copy over stuff to /etc
cp -Rf /tmp/config/etc/* /etc/

source /etc/environment
export JAVA_HOME=/usr/lib/jvm/default-java

# create self signed certs and put them in the right place if needed
FILE=/etc/ssl/private/idp3.inacademia.local.key
if [ -f "$FILE" ]; then
    echo "$FILE exist"
else
    echo "$FILE does not exist, creating"
    openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/idp3.inacademia.local.key -out /etc/ssl/certs/idp3.inacademia.local.crt -nodes -days 1095 -subj '/CN=idp3.inacademia.local'
fi


# Installing Jetty
cd /usr/local/src
VERSION=9.4.19.v20190610
DIST=jetty-distribution-$VERSION
TARGZ=$DIST.tar.gz
if [ -d "$DIST" ]; then
    echo "$DIST exists"
else
	wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/$VERSION/$TARGZ
	tar xzvf $TARGZ
	ln -s $DIST jetty-src
	rm $TARGZ
fi
useradd -r -m jetty

# set up jetty config
mkdir /opt/jetty
cp /tmp/config/opt/jetty/start.ini /opt/jetty/start.ini
mkdir /opt/jetty/tmp
chown jetty:jetty /opt/jetty/tmp
chown -R jetty:jetty /opt/jetty/ /usr/local/src/jetty-src
cd /etc/init.d
ln -s /usr/local/src/jetty-src/bin/jetty.sh jetty
update-rc.d jetty defaults
mkdir /var/log/jetty
mkdir /opt/jetty/logs
chown jetty:jetty /var/log/jetty /opt/jetty/logs

# Starting jetty
service jetty start
service jetty check

# Installing shibboleth
cd /usr/local/src
VERSION=4.0.1
DIST=shibboleth-identity-provider-$VERSION
TARGZ=$DIST.tar.gz
WAR=/opt/shibboleth-idp/war/idp.war
JSTL=https://build.shibboleth.net/nexus/service/local/repositories/thirdparty/content/javax/servlet/jstl/1.2/jstl-1.2.jar
if [ -d "$DIST" ]; then
    echo "$DIST exist"
else
    wget http://shibboleth.net/downloads/identity-provider/$VERSION/$TARGZ
    tar -xzvf $TARGZ
    wget $JSTL -O $DIST/webapp/WEB-INF/lib/jstl-1.2.jar
    #echo "Accept all defaults"
    #eread
    ./$DIST/bin/install.sh -Didp.target.dir=/opt/shibboleth-idp -Didp.host.name=idp3.inacademia.local -Didp.sealer.password=secret \
	-Didp.keystore.password=secret -Didp.src.dir=/usr/local/src/shibboleth-identity-provider-$VERSION -Didp.scope=inacademia.local \
	-Didp.noprompt=true -Didp.entityID=https://idp3.inacademia.local/idp/shibboleth

    cd /opt/shibboleth-idp
    chown -R jetty logs/ metadata/ credentials/ conf/ system/ war/
    rm conf/idp.properties
    ln -s /tmp/config/opt/shibboleth-idp/conf/idp.properties conf/idp.properties
    rm conf/ldap.properties
    ln -s /tmp/config/opt/shibboleth-idp/conf/ldap.properties conf/ldap.properties
    rm conf/saml-nameid.properties
    ln -s /tmp/config/opt/shibboleth-idp/conf/saml-nameid.properties conf/saml-nameid.properties
    rm conf/attribute-resolver.xml
    ln -s /tmp/config/opt/shibboleth-idp/conf/attribute-resolver.xml conf/attribute-resolver.xml
    rm conf/attribute-filter.xml
    ln -s /tmp/config/opt/shibboleth-idp/conf/attribute-filter.xml conf/attribute-filter.xml
    rm conf/saml-nameid.xml
    ln -s /tmp/config/opt/shibboleth-idp/conf/saml-nameid.xml conf/saml-nameid.xml
    rm conf/relying-party.xml
    ln -s /tmp/config/opt/shibboleth-idp/conf/relying-party.xml conf/relying-party.xml
    rm metadata/idp-metadata.xml
    ln -s /tmp/config/opt/shibboleth-idp/metadata/idp-metadata.xml metadata/idp-metadata.xml
    ln -s /tmp/config/opt/shibboleth-idp/metadata/sp-metadata.xml metadata/sp-metadata.xml
    rm credentials/idp-signing.key
    ln -s /tmp/config/opt/shibboleth-idp/credentials/idp-signing.key credentials/idp-signing.key
    rm credentials/idp-signing.crt
    ln -s /tmp/config/opt/shibboleth-idp/credentials/idp-signing.crt credentials/idp-signing.crt
fi

# Setting up Apache
mkdir /var/www/html/idp3.inacademia.local
chown -R www-data: /var/www/html/idp3.inacademia.local
a2enmod proxy_http ssl headers alias include negotiation
a2ensite idp3.inacademia.local
a2dissite 000-default.conf
service apache2 restart

# set up Jetty for IdP
mkdir -p /opt/jetty/webapps
cp /tmp/config/opt/jetty/webapps/idp.xml /opt/jetty/webapps/idp.xml

# test idp availability
export JAVA_HOME=/usr/lib/jvm/default-java
cd /opt/shibboleth-idp/bin
echo "============================================================================"
./status.sh

# export DEBIAN_FRONTEND=dialog
# echo "Accept all defaults, use admin pwd test"
# read
# rm -rf /var/backups/*
# dpkg-reconfigure slapd
service slapd restart

# Test authenticated access
ldapsearch -x -H ldapi:/// -D cn=admin,dc=inacademia,dc=local -w test -b dc=inacademia,dc=local

# Add people
ldapmodify -x -H ldapi:/// -D cn=admin,dc=inacademia,dc=local -w test -f /tmp/config/etc/ldap/people.ldif -c

# Show available accounts
ldapsearch -x -H ldapi:/// -D cn=admin,dc=inacademia,dc=local -w test -b dc=inacademia,dc=local

service jetty stop
service jetty disable

# install and setup phpldapadmin
# apt -y install phpldapadmin
# cp /tmp/config/etc/phpldapadmin/config.php /etc/phpldapadmin/config.php

touch /root/setup_complete
