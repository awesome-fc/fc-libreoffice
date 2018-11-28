#!/bin/bash
set -o xtrace

[ ! "$(docker ps -a | grep libreoffice-builder)" ] &&  docker run --rm --name libreoffice-builder -t -d -v $(pwd):/code --entrypoint /bin/sh aliyunfc/runtime-nodejs8

docker exec -t libreoffice-builder npm install
docker exec -t libreoffice-builder apt-get install -y -d -o=dir::cache=/code libnss3
docker exec -t libreoffice-builder bash -c 'for f in $(ls /code/archives/*.deb); do dpkg -x $f $(pwd) ; done;'
docker exec -t libreoffice-builder bash -c "rm -rf /code/archives/; mkdir -p /code/lib;cd /code/lib; find ../usr/lib -type f \( -name '*.so' -o -name '*.chk' \) -exec ln -sf {} . \;"

source "`dirname \"$0\"`"/../.env

ossutil cp "`dirname \"$0\"`"/../node_modules/fc-libreoffice/bin/lo.tar.br oss://${LIBREOFFICE_BUCKET}/lo.tar.br \
     -i ${FC_ACCESS_KEY_ID} -k ${FC_ACCESS_KEY_SECRET} -e ${LIBREOFFICE_REGION}.aliyuncs.com -f

rm "`dirname \"$0\"`"/../node_modules/fc-libreoffice/bin/lo.tar.br

docker stop libreoffice-builder