#!/bin/bash

current_date=`date '+%b-%d-%Y'`
stage_dir="/home/daniel.higgins-umw/project_data/RNA-Seq-Nextflow/utility/Results-${current_date}"

project_dir="/home/daniel.higgins-umw/project_data/Francis_Lab/unc17_eat4-Nov--2023"
project_results="${project_dir}/results"
project_data="${project_dir}/data"

# If the results directory aready exists recreate it
if [ -d "$stage_dir" ]; then
    echo "Directory exists. Deleting..."
    rm -r "$stage_dir"
fi

sub_dir_list="00-Overview 01-Quality_Control 02-Quantification 03-Differential_Expression 04-Functional_Analysis"
IFS=' ' read -r -a sub_dirs <<< "$sub_dir_list"

for dir in "${sub_dirs[@]}"; do
    mkdir -p ${stage_dir}/${dir}
done


# Stage 00-Overview
cp ${project_results}/overview_report.pdf ${stage_dir}/${sub_dirs[0]}/

# Stage 01-Quality_Control
fastqc_dir=${stage_dir}/${sub_dirs[1]}/fastqc 
mkdir -p ${fastqc_dir}
cp ${project_results}/fastqc/**/*.html ${fastqc_dir}/
cp ${project_results}/multiqc_*report.html ${stage_dir}/${sub_dirs[1]}/
cp ${project_results}/md5_report.html ${stage_dir}/${sub_dirs[1]}/

# # Stage 02-Quantification
mkdir -p ${stage_dir}/${sub_dirs[2]}/results
cp ${project_results}/rsem_expression/**/*.results ${stage_dir}/${sub_dirs[2]}/results
cp ${project_results}/rsem_summary/* ${stage_dir}/${sub_dirs[2]}/
cp ${project_data}/wormbase/*.geneIDs.csv ${stage_dir}/${sub_dirs[2]}/

# Stage 03-Differential_Expression
#cp -r ${project_results}/deseq_* ${stage_dir}/${sub_dirs[3]}/
find "${project_results}" -type d -name "deseq_*" -exec cp -r {} "${stage_dir}/${sub_dirs[3]}/" \; 
cp ${project_results}/deseq_report.pdf ${stage_dir}/${sub_dirs[3]}/  

# Stage 04-Functional_Analysis
cp -r ${project_results}/wormcat/wormcat_* ${stage_dir}/${sub_dirs[4]}/
find ${stage_dir}/${sub_dirs[4]}/ -type f -name "*.zip" -delete
cp -r ${project_results}/wormcat/wormcat_*/**/*.xlsx ${stage_dir}/${sub_dirs[4]}/

