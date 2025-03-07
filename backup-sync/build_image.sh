#!/bin/sh

docker pull alpine:latest
docker build --no-cache -t backup-sync:latest .
