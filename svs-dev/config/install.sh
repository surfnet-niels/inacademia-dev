#!/bin/bash
if ! [ -f /.dockerenv ]; then
    echo "I'm not a docker";
    exit 1
fi

echo "Using SaToSa version:" $SATOSA_TAG
echo "Using SVS version:" $SVS_TAG
GIT_SSH_COMMAND='ssh -i /tmp/inacademia/id_rsa_inacademia -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

mkdir -p /opt/workdir
/usr/bin/git clone -b $SATOSA_TAG git@github.com:inacademia-development/SATOSA.git /opt/workdir/satosa || /usr/bin/git -C /opt/workdir/satosa checkout -b $SATOSA_TAG  && /usr/bin/git -C /opt/workdir/satosa pull origin $SATOSA_TAG
/usr/bin/git clone -b $SVS_TAG git@github.com:inacademia-development/svs.git /opt/workdir/svs || /usr/bin/git -C /opt/workdir/svs checkout -b $SVS_TAG && /usr/bin/git -C /opt/workdir/svs pull origin $SVS_TAG
virtualenv --python=python3 /opt/workdir/svs_venv
source /opt/workdir/svs_venv/bin/activate
pip3 install -e /opt/workdir/satosa
pip3 install -e /opt/workdir/svs
# pip3 install pystache
touch /opt/workdir/svs_venv/installed
/bin/chown -Rf $MY_HOST_UID /opt/workdir
