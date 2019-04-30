#! /bin/bash
source svs.cnf
CONTAINER_NAME=${IMAGE_NAME}:${IMAGE_VERSION}_${DOCKER_VERSION}
echo $CONTAINER_NAME
# Get fresh idp metadata
curl https://idp.inacademia.local/saml2/idp/metadata.php -o config/production/idp.xml -k

# Start SVS
docker run -i $CONTAINER_NAME
