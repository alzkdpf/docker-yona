#!/bin/bash
echo "start docker...."
source ./config/config.sh

docker run \
--name yona \
--env-file=./env/docker-config.env \
-v $YONA_HOME:/yona/home/ \
-v $YONA_DATA:/yona_data/ \
-p $YONA_PORT:9000 \
--link $YONA_DB_CONTAINER_NAME:$DB_DEFAULT_URL_DOMAIN \
-d $CONTAINER_NAME
