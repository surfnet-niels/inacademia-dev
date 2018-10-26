#! /bin/bash

IMAGE_TAG=inacademia/svs-dev:v1

# make sure we have the latest metadata from the IdP
/usr/bin/curl -ksS https://idp.inacademia.local/saml2/idp/metadata.php > config/production/idp.xml

# create workdir
mkdir -p workdir

# As the build command is being called, we assume we need to build a new image.
# To be sure we therefor first remove existign ones
if [[ "$(docker images -q $IMAGE_TAG 2> /dev/null)" != "" ]]; then
  echo "Removing existing $IMAGE_TAG docker container ..."
  docker rmi -f $IMAGE_TAG
fi

echo "Building  docker container $IMAGE_TAG ..."
# Build the docker image
docker build -t $IMAGE_TAG .

