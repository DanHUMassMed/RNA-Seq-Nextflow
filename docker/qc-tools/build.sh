#!/bin/bash
USER="danhumassmed"
TAG="qc-tools"
VERSION="1.0.2"
SHORT_DESC="Software for Bioinformatics pipelines FastQC, MultiQC, RSeQC"
echo "********************************************"
echo ../push_description.py -u \"${USER}\" -i ${USER}/${TAG} -r README.md -s \"${SHORT_DESC}\"

echo "********************************************"
echo docker buildx build --platform linux/amd64 --no-cache --load -t ${USER}/${TAG}:${VERSION} .
echo docker push ${USER}/${TAG}:${VERSION}

echo "********************************************"
echo docker run --platform linux/amd64 -v '$(pwd)':/app/data -t ${USER}/${TAG}:${VERSION} /app/md2pdf.py convert data/overview.md data/overview.css
