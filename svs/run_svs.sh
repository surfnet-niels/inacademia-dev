#! /bin/bash
source svs.cnf
CONTAINER_NAME=${IMAGE_NAME}:${IMAGE_VERSION}_${DOCKER_VERSION}
echo $CONTAINER_NAME

# Start SVS
docker run -i $CONTAINER_NAME
