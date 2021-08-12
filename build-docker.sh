#!/bin/bash

REPO_VERSION=`date +%F`

# 跨平台构建，需要启用 Docker BuildKit:
# https://docs.docker.com/buildx/working-with-buildx/
echo "[IMAGE BUILD] Using docker build kit ..."
docker buildx create --use --name gobuild --driver docker-container --driver-opt image=dockerpracticesig/buildkit:master
docker buildx use gobuild

# 需要多平台支持: --platform linux/arm,linux/arm64,linux/amd64
docker buildx build --platform linux/amd64,linux/arm64 --push -t bytepoweredgo/httpd:latest .

if [ $? -eq 0 ]; then
   docker tag bytepoweredgo/httpd:latest bytepoweredgo/httpd:${REPO_VERSION}
   docker push bytepoweredgo/httpd:latest && docker push bytepoweredgo/httpd:${REPO_VERSION}
fi

