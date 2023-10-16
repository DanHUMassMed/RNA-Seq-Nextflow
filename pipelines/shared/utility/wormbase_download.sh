#!/bin/bash
# Select Version from https://wormbase.org/ 
wormbase_version="WS289"

launch_dir="/home/${USER}/project_data/RNA-Seq-Nextflow"
base_dir="${launch_dir}/pipelines/shared/data"

base_url="ftp://ftp.wormbase.org/pub/wormbase/releases/${wormbase_version}/species/c_elegans/PRJNA13758"
genes_fasta="c_elegans.PRJNA13758.${wormbase_version}.genomic.fa.gz"
transcripts_fasta="c_elegans.PRJNA13758.${wormbase_version}.mRNA_transcripts.fa.gz"
annotations_gtf="c_elegans.PRJNA13758.${wormbase_version}.canonical_geneset.gtf.gz"
gene_ids="c_elegans.PRJNA13758.${wormbase_version}.geneIDs.txt.gz"

mkdir -p ${base_dir}
cd ${base_dir}

wget -nv ${base_url}/${genes_fasta}
wget -nv ${base_url}/${transcripts_fasta}
wget -nv ${base_url}/${annotations_gtf}
wget -nv ${base_url}/annotation/${gene_ids}
gunzip --force ${genes_fasta}
gunzip --force ${transcripts_fasta}
gunzip --force ${annotations_gtf}
gunzip --force ${gene_ids}