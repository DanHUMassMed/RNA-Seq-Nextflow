#!/bin/bash
USER="danhumassmed"
TAG="fastqc-multiqc"
VERSION="1.0.0"
echo "********************************************"
echo docker build -t ${USER}/${TAG}:${VERSION} .
docker build -t ${USER}/${TAG}:${VERSION} .
echo "********************************************"
echo docker push  ${USER}/${TAG}:${VERSION}
docker push  ${USER}/${TAG}:${VERSION}
