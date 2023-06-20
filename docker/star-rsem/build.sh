#!/bin/bash
USER="danhumassmed"
TAG="star-rsem"
VERSION="1.0.0"
echo docker buildx build --platform linux/amd64,linux/arm64 --push -t ${USER}/${TAG}:${VERSION} .
