#!/bin/sh

PORT=$1
LOG=$2

if [ -z "${PORT}" ] || [ -z "${LOG}" ]; then
    echo "Invalid arguments";
    return 1;
fi 

LOG=$(realpath "${LOG}")

docker run \
    --name keepass \
    --restart=unless-stopped \
    -p "${PORT}":22 \
    -v keepass-ssh:/ssh \
    -v "${LOG}":/var/log \
    keepass &
