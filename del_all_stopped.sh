#!/bin/bash

#    delete all stopped containers 
docker rm $(docker ps -a -q)
