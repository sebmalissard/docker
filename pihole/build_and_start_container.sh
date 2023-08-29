#!/bin/sh
#
# Fist connection:
#    http://<IP>:<PORT>/admin
#
# Get default password:
#    docker logs pihole | grep password
#
# Create a more complexe password:
#    docker exec -it <NAME> pihole -a -p

export PIHOLE_NAME=$1
export PIHOLE_HTTP_PORT=$2

docker-compose up -d
