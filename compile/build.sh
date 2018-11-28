#!/usr/bin/env bash
set -e
set -o pipefail

[ ! "$(docker ps -a | grep libre-builder)" ] && docker run --name libre-builder --rm  -v $(pwd):/code -d -t --cap-add=SYS_PTRACE --security-opt seccomp=unconfined aliyunfc/runtime-nodejs8:build bash
docker exec -t libre-builder ./compile.sh
docker cp libre-builder:/code/libreoffice/lo.tar.gz ./lo.tar.gz

[ ! "$(docker ps -a | grep brotli-util)" ] && docker run --name brotli-util --rm -v $(pwd):/root -w /root -d -t ubuntu:18.04 bash
docker exec -t brotli-util apt-get update
docker exec -t brotli-util apt-get install -y brotli
docker exec -t brotli-util gzip -d lo.tar.gz
docker exec -t brotli-util brotli -q 11 -j -f lo.tar

docker stop libre-builder
docker stop brotli-util
