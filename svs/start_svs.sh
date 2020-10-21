#! /bin/bash
source svs.cnf
CONTAINER_NAME=${IMAGE_NAME/\//_}
echo $CONTAINER_NAME

# Start SVS
docker start -i $CONTAINER_NAME
