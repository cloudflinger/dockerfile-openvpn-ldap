#!/bin/bash

set -e

PROJECT=cloudflinger
LOCAL_IMAGE_NAME="openvpn-ldap"
REMOTE_IMAGE_NAME="${PROJECT}/${LOCAL_IMAGE_NAME}"

if [ ! -f ./Dockerfile ]; then
  echo "Please run this from the directory with the Dockerfile."
fi

if [ ! -f ./Version ]; then
  echo "Please include a VERSION file."
fi

VERSION=$(cat VERSION)
echo "Building version ${VERSION}."

docker build -t $LOCAL_IMAGE_NAME .

docker tag $LOCAL_IMAGE_NAME $REMOTE_IMAGE_NAME
docker tag $LOCAL_IMAGE_NAME $REMOTE_IMAGE_NAME:latest
docker tag $LOCAL_IMAGE_NAME $REMOTE_IMAGE_NAME:${VERSION}

docker push $REMOTE_IMAGE_NAME
docker push $REMOTE_IMAGE_NAME:latest
docker push $REMOTE_IMAGE_NAME:$VERSION
