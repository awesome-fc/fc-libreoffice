#!/bin/bash

[ ! "$(docker ps -a | grep libreoffice-builder)" ] &&  docker run --rm --name libreoffice-builder -t -d -v $(pwd):/code --entrypoint /bin/sh aliyunfc/runtime-nodejs8

docker exec -t libreoffice-builder npm install
docker exec -t libreoffice-builder apt-get install -y -d -o=dir::cache=/code libnss3
docker exec -t libreoffice-builder bash -c 'for f in $(ls /code/archives/*.deb); do dpkg -x $f $(pwd) ; done;'
docker exec -t libreoffice-builder bash -c "rm -rf /code/archives/; mkdir -p /code/lib;cd /code/lib; find ../usr/lib -type f \( -name '*.so' -o -name '*.chk' \) -exec ln -sf {} . \;"

SCRIPT_DIR=`dirname -- "$0"`

source $SCRIPT_DIR/../.env

UPLOADED=0
if ossutil ls oss://${OSS_BUCKET}/lo.tar.br -e oss-${ALIBABA_CLOUD_DEFAULT_REGION}.aliyuncs.com -i ${ALIBABA_CLOUD_ACCESS_KEY_ID} -k ${ALIBABA_CLOUD_ACCESS_KEY_SECRET}  | grep "Object Number is: 1" > /dev/null ; then
    echo "lo.tar.br is already uploaded!"
    UPLOADED=1
fi

[ ! $UPLOADED ] && ossutil cp $SCRIPT_DIR/../node_modules/fc-libreoffice/bin/lo.tar.br oss://${OSS_BUCKET}/lo.tar.br \
     -i ${ALIBABA_CLOUD_ACCESS_KEY_ID} -k ${ALIBABA_CLOUD_ACCESS_KEY_SECRET} -e oss-${ALIBABA_CLOUD_DEFAULT_REGION}.aliyuncs.com -f

rm -f "`dirname \"$0\"`"/../node_modules/fc-libreoffice/bin/lo.tar.br

docker stop libreoffice-builder