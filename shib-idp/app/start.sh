#!/bin/bash

if [ ! -f "/root/setup_complete" ]; 
then
    echo "/root/setup_complete not found - runnning initial setup process"
    source /tmp/app/install.sh
else 
    echo "/root/setup_complete found - *not* running initial setup process"
fi

echo "Ensure apache2 is started"
service apache2 restart

echo "Ensure slapd is started"
service slapd restart

echo "Starting Jetty"
cd /opt/jetty
java -jar /usr/local/src/jetty-src/start.jar