#!/bin/bash

# delete all images
docker rmi $(docker images -q)
