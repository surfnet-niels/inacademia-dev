#! /bin/bash
source svs.cnf
CONTAINER_NAME=${IMAGE_NAME/\//_}

# Get fresh idp metadata
curl https://idp.inacademia.local/saml2/idp/metadata.php -o config/production/idp.xml -k

# Start SVS
docker start -i $CONTAINER_NAME
