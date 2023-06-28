#!/bin/bash
USER="danhumassmed"
TAG="wormcat_batch"
VERSION="1.0.1"
#docker build -t danhumassmed/wormcat_batch:1.0.1 .
echo docker buildx build --platform linux/amd64 --push -t ${USER}/${TAG}:${VERSION} .
