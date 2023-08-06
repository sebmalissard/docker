#!/bin/sh

export WEBSITE_NAME=$1
export WEBSITE_PORT=$2
export WEBSITE_SOURCE=$3

if [ -z "${WEBSITE_NAME}" ] || [ -z "${WEBSITE_PORT}" ] || [ -z "${WEBSITE_SOURCE}" ]; then
    echo "Invalid arguments";
    return 1;
fi

docker-compose up -d
