#!/bin/bash
export YONA_HOME="/your-yona-directory/"
echo "yona home path :  $YONA_HOME"
export YONA_DATA="/your-yona-data/"
echo "yona data path : $YONA_DATA"
export YONA_PORT=9002
echo "yona service port : $YONA_PORT"
export CONTAINER_NAME="yona:1.7.0"
echo "container name : $CONTAINER_NAME"
export YONA_DB_CONTAINER_NAME="your-yona-docker-container-name"
echo "DB container name : $YONA_DB_CONTAINER_NAME"
export DB_DEFAULT_URL_DOMAIN="localhost-or-define-your-custom-name"
echo "application conf db name : $DB_DEFAULT_URL_DOMAIN"
