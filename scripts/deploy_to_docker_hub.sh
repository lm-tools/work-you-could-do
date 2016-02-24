#! /usr/bin/env bash

set -e

docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker build --build-args version $DOCKER_VERSION -t $DOCKER_IMAGE:$DOCKER_VERSION .
docker tag $DOCKER_IMAGE:$DOCKER_VERSION $DOCKER_IMAGE:latest
docker push $DOCKER_IMAGE
