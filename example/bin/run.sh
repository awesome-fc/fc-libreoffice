#!/bin/bash

SCRIPT_DIR=`dirname -- "$0"`

source $SCRIPT_DIR/../.env

set -o xtrace
docker run --rm -v $(pwd):/code -v $(pwd)/tmp:/tmp \
    -e FC_ACCESS_KEY_ID=$ALIBABA_CLOUD_ACCESS_KEY_ID \
    -e FC_ACCESS_KEY_SECRET=$ALIBABA_CLOUD_ACCESS_KEY_SECRET \
    -e ALIBABA_CLOUD_DEFAULT_REGION=$ALIBABA_CLOUD_DEFAULT_REGION \
    -e OSS_BUCKET=$OSS_BUCKET \
    aliyunfc/runtime-nodejs8 --handler index.handler --initializer index.initializer