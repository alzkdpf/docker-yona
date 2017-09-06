#!/bin/sh
source ./config/config.sh

echo "build docker image"
docker build -t $CONTAINER_NAME .
