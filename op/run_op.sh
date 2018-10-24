#! /bin/bash
IMAGE_TAG=inacademia/op:v1
CONTAINER_NAME=inacademia_op

# Build the docker image if needed
if [[ "$(docker images -q $IMAGE_TAG 2> /dev/null)" == "" ]]; then
  docker build -t $IMAGE_TAG .
fi

# find the location of configs in current directory structure
RUN_DIR=$PWD
SSL_DIR="$RUN_DIR/config/etc/ssl"

# Start SSP IDP
docker start -i $CONTAINER_NAME || docker run -it \
    --name $CONTAINER_NAME \
    --net inacademia.local --ip 172.172.172.2 \
    -e BACKEND_PORT=tcp://172.172.172.1:80 \
    -e REWRITE_LOCATION=0 \
    --add-host=svs.inacademia.local:172.172.172.1 \
    --add-host=op.inacademia.local:172.172.172.2 \
    --add-host=rp.inacademia.local:172.172.172.100 \
    --add-host=idp.inacademia.local:172.172.172.200 \
    --hostname op.inacademia.local \
    --expose 80 \
    --expose 443 \
    -v $SSL_DIR:/etc/ssl \
    $IMAGE_TAG

