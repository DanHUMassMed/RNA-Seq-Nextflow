#!/bin/bash

current_date=`date '+%b-%d-%Y'`
results_base_dir="/home/${USER}/Results-${current_date}"

launch_dir="/home/${USER}/project_data/RNA-Seq-Nextflow"
project_results="${launch_dir}/pipelines/alex_byrne/results"

# If the results directory aready exists recreate it
if [ -d "$results_base_dir" ]; then
    echo "Directory exists. Deleting..."
    rm -r "$results_base_dir"
fi

sub_dir="00-Overview 01-Quality_Control 02-Quantification 03-Differential_Expression 04-Functional_Analysis"
for d in `echo $sub_dir`;do
    mkdir -p ${results_base_dir}/${d}
done

# Stage 00-Overview
# PASS

# Stage 01-Quality_Control
cp -r ${project_results}/fastqc_* ${results_base_dir}/01-Quality_Control
cp ${project_results}/multiqc_rsem_report.html ${results_base_dir}/01-Quality_Control

# Stage 02-Quantification
cp -r ${project_results}/rsem_expression_*/*.genes.results ${results_base_dir}/02-Quantification/
cp -r ${project_results}/rsem_expression_*/*.isoforms.results ${results_base_dir}/02-Quantification/
cp -r ${project_results}/rsem_summary/* ${results_base_dir}/02-Quantification/
cp -r ${launch_dir}/pipelines/shared/data/c_elegans.PRJNA13758.WS289.geneIDs.txt ${results_base_dir}/02-Quantification/

echo "Results staged at: ${results_base_dir}"