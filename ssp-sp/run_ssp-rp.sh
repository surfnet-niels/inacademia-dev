#! /bin/bash

# Steup the netwerk if needed
if [ ! "$(docker network ls | grep inacademia.local)" ]; then
  echo "Creating inacademia.local network ..."
  ../dockernet.sh
else
  echo "inacademia.local network exists."
fi
# Build the docker image if needed
if [[ "$(docker images -q inacademia/ssp-idp:v1 2> /dev/null)" == "" ]]; then
  echo "Creating inacademia/ssp-idp:v1 docker container ..."
  docker build -t inacademia/ssp-idp:v1 .
else
  echo "inacademia/ssp-idp:v1 docker container exists..."
fi

# Start SSP IDP
docker run \
	--net inacademia.local \
	--ip 172.172.172.200 \
	--add-host=svs.inacademia.local:172.172.172.1 \
	--add-host=op.inacademia.local:172.172.172.2 \
	--add-host=rp.inacademia.local:172.172.172.100 \
	--add-host=idp.inacademia.local:172.172.172.200 \
	--hostname idp.inacademia.local \
	--expose 80 \
	--expose 443 \
	-p 443:443 \
	-it inacademia/ssp-idp:v1
