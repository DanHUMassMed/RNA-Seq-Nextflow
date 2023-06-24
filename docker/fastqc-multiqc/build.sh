#!/bin/bash
USER="danhumassmed"
TAG="fastqc-multiqc"
VERSION="1.0.1"
echo "********************************************"
echo docker buildx build --platform linux/amd64,linux/arm64 --push -t ${USER}/${TAG}:${VERSION} .
