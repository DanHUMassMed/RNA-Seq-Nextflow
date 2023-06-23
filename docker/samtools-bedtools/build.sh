#!/bin/bash
USER="danhumassmed"
TAG="samtools-bedtools"
VERSION="1.0.1"
echo "********************************************"
echo docker buildx build --platform linux/amd64 --push -t ${USER}/${TAG}:${VERSION} .
