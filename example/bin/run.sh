#!/bin/bash

mkdir -p tmp/

cp example.docx tmp/

docker run --rm -v $(pwd):/code -v $(pwd)/tmp:/tmp aliyunfc/runtime-nodejs8 --handler index.handler