#!/bin/bash
base_dir="/home/daniel.higgins-umw/project_data/RNA-Seq-Nextflow/data"
murphy_data="http://www.wormcat.com/static/download/Murphy_TS.xlsx"
mkdir -p ${base_dir}
cd ${base_dir}

wget -nv ${murphy_data}
