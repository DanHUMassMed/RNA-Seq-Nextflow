#!/bin/bash
# Select Version from https://wormbase.org/ 
wormbase_version="WS289"

launch_dir="/home/daniel.higgins-umw/project_data/RNA-Seq-Nextflow"
base_dir="${launch_dir}/pipelines/shared/data"

base_url="ftp://ftp.wormbase.org/pub/wormbase/releases/${wormbase_version}/species/c_elegans/PRJNA13758/"
genes_fasta="c_elegans.PRJNA13758.${wormbase_version}.genomic.fa.gz"
transcripts_fasta="c_elegans.PRJNA13758.${wormbase_version}.mRNA_transcripts.fa.gz"
annotations_gtf="c_elegans.PRJNA13758.${wormbase_version}.canonical_geneset.gtf.gz"

mkdir -p ${base_dir}
cd ${base_dir}

wget -nv ${base_url}/${genes_fasta}
wget -nv ${base_url}/${transcripts_fasta}
wget -nv ${base_url}/${annotations_gtf}
gunzip ${genes_fasta}
gunzip ${transcripts_fasta}
gunzip ${annotations_gtf}