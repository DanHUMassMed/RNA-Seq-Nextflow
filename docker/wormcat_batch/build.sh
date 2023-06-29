#!/bin/bash
USER="danhumassmed"
TAG="wormcat_batch"
VERSION="1.0.1"
SHORT_DESC="Software for Bioinformatics pipelines Wormcat"
echo "********************************************"
echo ../push_description.py -u \"${USER}\" -i ${USER}/${TAG} -r README.md -s \"${SHORT_DESC}\"

#docker build -t danhumassmed/wormcat_batch:1.0.1 .
echo docker buildx build --platform linux/amd64 --push -t ${USER}/${TAG}:${VERSION} .
