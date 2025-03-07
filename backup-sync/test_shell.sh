#!/bin/sh

. ./secret.sh

docker run -e URL=$URL -e USER=$USER -e PASS=$PASS -e CRYPT_PWD1=$CRYPT_PWD1 -e CRYPT_PWD2=$CRYPT_PWD2 -it --privileged --device /dev/fuse -v "$PWD/test":/mnt --entrypoint sh backup-sync