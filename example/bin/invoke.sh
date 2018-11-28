#!/bin/bash

SCRIPT_DIR=`dirname -- "$0"`

source $SCRIPT_DIR/../.env

set -o xtrace
fcli function invoke -s libre-svc -f libre-fun
