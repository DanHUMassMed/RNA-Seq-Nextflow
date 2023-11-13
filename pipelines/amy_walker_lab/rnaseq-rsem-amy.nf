#!/usr/bin/env nextflow 

// nextflow run pipelines/amy_walker/rnaseq-rsem.nf -resume -bg -N daniel.higgins@umassmed.edu

/* 
 * enables modules 
 */
nextflow.enable.dsl = 2

/*
 * RNA SEQ Pipeline 
 */

params.reads = "${projectDir}/data/Experiment1/**/*.fq.gz"
params.star_index_dir="${launchDir}/pipelines/shared/results/star_index"
params.rsem_reference_dir = "${launchDir}/pipelines/shared/results/rsem_index"
params.outdir = "${projectDir}/results"


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 reads              : ${params.reads}
 star_index_dir     : ${params.star_index_dir}
 rsem_reference_dir : ${params.rsem_reference_dir}
 outdir             : ${params.outdir}
 project_dir        : ${projectDir}
 launch_dir         : ${launchDir}
 """

// import modules
include { RNASEQ_STAR_RSEM_SINGLE } from "${launchDir}/modules/subworkflows/rnaseq-star-rsem"
include { MULTIQC } from "${launchDir}/modules/multiqc"

/* 
 * main script flow
 */
workflow {
  read_ch = channel.fromPath( params.reads, checkIfExists: true ) 
  report_nm = channel.value("multiqc_rsem_report.html")

  RNASEQ_STAR_RSEM_SINGLE( params.star_index_dir, params.rsem_reference_dir, read_ch )
  MULTIQC(report_nm, RNASEQ_STAR_RSEM_SINGLE.out )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.outdir}/multiqc_rsem_report.html\n" : "Oops .. something went wrong" )
}
