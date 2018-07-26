# Simple Validation Service docker image
Necessary files for building a Docker image for running an
[svs](https://github.com/its-dirg/svs) instance.

Build
-----
docker build -t svs:1.0.0 .

Run
---
docker run -ti --name svs \
    -v /home/user/src/svs/conf:/var/svs
    -e DATA_DIR="/var/svs" \
    -e PROXY_PORT="8888" \
    -p 8888:8888
    svs:1.0.0
