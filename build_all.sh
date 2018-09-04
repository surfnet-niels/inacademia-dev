#! /bin/bash
cd oidc-rp/
./build_oidc-rp.sh
cd ..

cd op/
./build_op.sh
cd ..

cd ssp-idp/
./build_ssp-idp.sh
cd ..

cd svs/
./build_svs.sh
cd ..

cd svs-dev/
./build_svs.sh
cd ..
