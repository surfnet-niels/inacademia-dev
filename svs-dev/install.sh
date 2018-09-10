#!/bin/bash
if ! [ -f /.dockerenv ]; then
    echo "I'm not a docker";
    exit 1
fi
mkdir -p /opt/workdir
git clone -b svs-1.0.1 https://github.com/InAcademia/SATOSA.git /opt/workdir/satosa
git clone https://github.com/inacademia-development/svs.git /opt/workdir/svs
virtualenv --python=python3 /opt/workdir/svs_venv
source /opt/workdir/svs_venv/bin/activate
pip3 install -e /opt/workdir/satosa
pip3 install -e /opt/workdir/svs
# pip3 install pystache
touch /opt/workdir/svs_venv/installed
