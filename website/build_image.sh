#!/bin/sh

docker pull alpine:latest
docker build --no-cache -t website:latest .
