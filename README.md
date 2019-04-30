# inacademia-dev
A self contained development environment for InAcademia

This set of containers is used to develop for InAcademia core service and to create and test containers for production platform.

## Architecture
The containers will be set up as following
```
   +-----+     +--------+    +-----+
   | IDP |-----|   OP   |----|  RP |
   +-----+     +--------+    +-----+
                    |
               +-----------+
               | SVS(-dev) |
               +-----------+
```
In this setup there is only 1 IdP and 1 RP

### idp.inacademia.local:172.172.172.200
* A simplesamlphp based IdP based on an ansible deployment from https://github.com/OpenConext/OpenConext-DIY

### rp.inacademia.local:172.172.172.100
* A RP based on Apache mod OIDC: https://github.com/zmartzone/mod_auth_openidc

### op.inacademia.local:172.172.172.2
* A https offloader and load balancer based on POUND: http://www.apsis.ch/pound
* This component proxies for the svs container

### svs.inacademia.local:172.172.172.1
* The core of the InAcademia service is provided by SaToSa: https://github.com/IdentityPython/SATOSA
* Which is complemented by an InAcademia specific overlay, the Simple Validation Service: https://github.com/inacademia-development/svs

The SVS container comes in 2 versions: 
* SVS is a container for building, testing and tagging containers that can be used in the production platform. 
* SVS-dev docker is availble to do code development while retaining the ability to directly work/code and use git in normal way (pull/commit, branches, etc)

### Networking
* The containers need a docker network to be able to reach each other. To set up the network run:
```dockernet.sh```
* To allow the docker host to access the containers as well (e.g. using a browser) please add the following to your hosts file:
```
172.172.172.1    svs.inacademia.local
172.172.172.2    op.inacademia.local
172.172.172.100  rp.inacademia.local                  
172.172.172.200  idp.inacademia.local
```

## Using idp
### Building the IdP container
Build the IdP container by running
```build_idp.sh```
No config changes are needed
### Running the IdP container
Run the IdP container by running
``` run_idp.sh```

## Using svs-dev

### Building a svs-dev container
To build a new container, first configure the environment by setting svs-dev.cnf

#### svs-dev.cnf
```
IMAGE_TAG=inacademia/svs-dev:v1
CONTAINER_NAME=inacademia_svs-dev

# SaToSa tag or branch - DO NOT CHANGE UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!!
SATOSA_TAG="svs-1.0.1"

# SVS tag or branch - You may also change this by checking out new versions or branches in the workdir
SVS_TAG="2.1.0"

# The SSH key for pull/commit in InAcademia repository 
GIT_KEY_PATH=/home/niels/keys/id_rsa_inacademia
```
You can use SATOSA_TAG and/or SVS_TAG to install specific versions into the container, however, this can also be updated lateron to any other version.

**You must change GIT_KEY_PATH to point to your GIT SSH key that allows you to push/commit into the inacademia-development repository**

#### Run IdP
When buildig the container will need to query the IdP for metadata. Therefor make sure the IdP is up and running and metadata is available at 
```https://idp.inacademia.local/saml2/idp/metadata.php```

Now build the svs-dev container by running
```build_idp.sh```

### Running the svs-dev container
Run the svs-dev container by running
``` run_svs-dev.sh```

### Developing agains the svs-dev container
#### Initial setup
To install a workign version of InAcademia into the container run once:
``` /tmp/inacademia/install.sh ```
at the prompt of the container. This is only needed for an initial setup.

#### Development
The container allows live updates on both code as well as configuration.
* To update **configuration** modify file in the ```svs-dev/config``` directory.
``` 
cdb -> the client (rp) database
production -> the SaToSa and SVS configuration
rsyslog -> rsyslog configuration (typically not in use)
```
* For **updating code**, the container exposes the deployed SaToSa and SVS code in the workdir, found at ```svs-dev/workdir```

```
satosa -> satosa as pulled from git@github.com:inacademia-development/SATOSA.git
svs -> svs as pulled from git@github.com:inacademia-development/svs.git
svs_venv -> virtualenv deployed version of svs
```
## Using rp
### Building the RP container
Build the RP container by running
```build_rp.sh```
No config changes are needed
### Running the RP container
Run the RP container by running
``` run_rp.sh```

You can now go to ```https://rp.inacademia.local/protected/``` to start of a validation request
Note that at startup of the Apache service, it tries to contact the OP to download the OP configuration from 
```https://op.inacademia.local/.well-known/openid-configuration```. **Therefor you must start the OP and SVS containers before starting the RP, or Apache will fail** This will yield an "Internal Server Error" upon accessing the RP in your browser

## Using op
### Building the OP container
Build the OP container by running
```build_op.sh```
No config changes are needed
### Running the OP container 
Run the OP container by running
``` run_op.sh```


