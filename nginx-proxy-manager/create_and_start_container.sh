#!/bin/sh

# First create network
# docker network create proxy_network

# Start
docker compose -f docker-compose.yml up -d

# Stop
# docker compose -f docker-compose.yml down