#! /bin/bash
cd rp/
./build_rp.sh
cd ..

cd op/
./build_op.sh
cd ..

cd idp/
./build_idp.sh
cd ..

cd svs/
./build_svs.sh
cd ..

cd svs-dev/
./build_svs-dev.sh
cd ..
