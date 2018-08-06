#!/bin/bash

# kill all running containers
docker kill $(docker ps -q)

#    delete all stopped containers with docker rm $(docker ps -a -q)
#    delete all images with docker rmi $(docker images -q)
