#!/bin/bash

SCRIPT_DIR=`dirname -- "$0"`

source $SCRIPT_DIR/../.env

ossutil cp  oss://${OSS_BUCKET}/example.pdf $SCRIPT_DIR/../example.pdf \
     -i ${ALIBABA_CLOUD_ACCESS_KEY_ID} -k ${ALIBABA_CLOUD_ACCESS_KEY_SECRET} -e oss-${ALIBABA_CLOUD_DEFAULT_REGION}.aliyuncs.com -f