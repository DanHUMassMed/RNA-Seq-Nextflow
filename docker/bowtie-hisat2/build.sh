#!/bin/bash
USER="danhumassmed"
TAG="bowtie-hisat2"
VERSION="1.0.2"
SHORT_DESC="Software for Bioinformatics pipelines samtools, Bowtie2 & HISAT2"
echo "********************************************"
echo ../push_description.py -u \"${USER}\" -i ${USER}/${TAG} -r README.md -s \"${SHORT_DESC}\"

echo "********************************************"
#echo docker buildx build --platform linux/amd64 --push -t ${USER}/${TAG}:${VERSION} .

echo docker buildx build --platform linux/amd64 --no-cache --load -t ${USER}/${TAG}:${VERSION} .
echo docker push ${USER}/${TAG}:${VERSION}

echo "********************************************"
echo docker run -t ${USER}/${TAG}:${VERSION} ${TAG} --version

