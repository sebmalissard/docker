#!/bin/sh

export NAME=${1:-wireguard-server}
export CONFIG_PATH=${2:-$PWD/config}

if [ -z "${NAME}" ] || [ -z "${CONFIG_PATH}" ]; then
    echo "Invalid arguments";
    return 1;
fi

docker-compose up -d
