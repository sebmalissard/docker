#!/bin/sh

. ./secret.sh

export MNT_PATH="$PWD/test"

docker-compose -f docker-compose-test.yml up -d
