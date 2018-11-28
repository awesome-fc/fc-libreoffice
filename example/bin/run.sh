#!/bin/bash
set -o xtrace

mkdir -p tmp/

cp example.docx tmp/

source "`dirname \"$0\"`"/../.env

docker run --rm -v $(pwd):/code -v $(pwd)/tmp:/tmp \
    -e FC_ACCESS_KEY_ID=$FC_ACCESS_KEY_ID \
    -e FC_ACCESS_KEY_SECRET=$FC_ACCESS_KEY_SECRET \
    -e LIBREOFFICE_REGION=$LIBREOFFICE_REGION \
    -e LIBREOFFICE_BUCKET=$LIBREOFFICE_BUCKET \
    aliyunfc/runtime-nodejs8 --handler index.handler --initializer index.initializer