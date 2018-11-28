#!/bin/bash
set -o xtrace

SCRIPT_DIR=`dirname -- "$0"`

source $SCRIPT_DIR/../.env

export ALIBABA_CLOUD_DEFAULT_REGION OSS_BUCKET
envsubst < $SCRIPT_DIR/../template.yml.tpl > $SCRIPT_DIR/../template.yml

cd $SCRIPT_DIR/../

fun deploy