#!/bin/sh

. ./secret.sh

export MNT_PATH="$PWD/test"

docker-compose up -d
