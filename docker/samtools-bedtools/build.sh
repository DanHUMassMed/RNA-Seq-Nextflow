#!/bin/bash
USER="danhumassmed"
TAG="samtools-bedtools"
VERSION="1.0.2"
SHORT_DESC="Software for Bioinformatics pipelines Samtools, Bedtools and MashMap"
echo "********************************************"
echo ../push_description.py -u \"${USER}\" -i ${USER}/${TAG} -r README.md -s \"${SHORT_DESC}\"

echo "********************************************"
echo docker buildx build --platform linux/amd64 --no-cache --load -t ${USER}/${TAG}:${VERSION} .
echo docker push ${USER}/${TAG}:${VERSION}
