#! /bin/bash

# As the build command is being called, we assume we need to build a new image. 
# To be sure we therefor first remove existign ones
if [[ "$(docker images -q inacademia/svs:v1 2> /dev/null)" != "" ]]; then
  echo "Removing existing inacademia/svs:v1 docker container ..."
  docker rmi inacademia/svs:v1
fi

echo "Building  docker container inacademia/svs:v1 ..."
# Build the docker image
docker build -t inacademia/svs:v1 .

