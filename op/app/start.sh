#!/bin/bash

#count=`find /etc/ssl/private/ -type f,l -a -name \*.pem 2>/dev/null |wc -l`
#if [ $count -eq 0 ]; then
#   make-ssl-cert generate-default-snakeoil
#   cat /etc/ssl/private/ssl-cert-snakeoil.key /etc/ssl/certs/ssl-cert-snakeoil.pem > /etc/ssl/private/server.pem
#fi

export HTTP_IP="127.0.0.1"
export HTTP_PORT="80"
if [ "x${BACKEND_PORT}" != "x" ]; then
   HTTP_IP=`echo "${BACKEND_PORT}" | sed 's%/%%g' | awk -F: '{ print $2 }'`
   HTTP_PORT=`echo "${BACKEND_PORT}" | sed 's%/%%g' | awk -F: '{ print $3 }'`
fi

if [ "x${REWRITE_LOCATION}" = "x" ]; then
   REWRITE_LOCATION=1
fi

mkdir -p /var/run/pound

cat>/etc/pound/pound.cfg<<EOF
User            "www-data"
Group           "www-data"
LogLevel        3
LogFacility     -
Alive           30
Control         "/var/run/pound/poundctl.socket"
Daemon          0

ListenHTTPS
    xHTTP 1
    Address 0.0.0.0
    Port    443
    Disable SSLv3
    HeadRemove "X-Forwarded-Proto"
    AddHeader "X-Forwarded-Proto: https"
    RewriteLocation ${REWRITE_LOCATION}
EOF
for c in /etc/ssl/private/*.pem; do
   echo "    Cert    \"$c\"" >> /etc/pound/pound.cfg
done
cat>>/etc/pound/pound.cfg<<EOF

    Ciphers "ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS"

    Service
        HeadRequire "Host:.*"
        BackEnd
            Address $HTTP_IP
            Port    $HTTP_PORT
        End
        Session
            Type    IP
            TTL     300
        End
    End
End
EOF

/usr/sbin/pound -v
#/bin/bash
