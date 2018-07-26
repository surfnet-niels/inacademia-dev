#! /bin/bash
IMAGE_TAG=inacademia/ssp-idp:v1

# As the build command is being called, we assume we need to build a new image. 
# To be sure we therefor first remove existign ones
if [[ "$(docker images -q $IMAGE_TAG 2> /dev/null)" != "" ]]; then
  echo "Removing existing $IMAGE_TAG docker container ..."
  docker rmi $IMAGE_TAG
fi

echo "Building  docker container $IMAGE_TAG ..."
# Build the docker image
docker build -t $IMAGE_TAG .

