#!/bin/bash
USER="danhumassmed"
TAG="star-rsem"
VERSION="1.0.1"
echo docker buildx build --platform linux/amd64 --push -t ${USER}/${TAG}:${VERSION} .
