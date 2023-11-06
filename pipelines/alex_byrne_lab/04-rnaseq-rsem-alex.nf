#!/usr/bin/env nextflow 

// nextflow run pipelines/alex_byrne/rnaseq-rsem-alex.nf -resume -bg -N daniel.higgins@umassmed.edu


nextflow.enable.dsl = 2

/*
 * RNA SEQ Pipeline 
 */

//params.reads = "${projectDir}/data/Experiment1/**/*_{1,2}.fq.gz"
params.reads = "${projectDir}/results/trimmed/**/*_{1,2}.fq.gz"
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
 """

// import modules
include { RNASEQ_STAR_RSEM } from "${launchDir}/modules/sub-workflow/rnaseq-star-rsem"
include { MULTIQC } from "${launchDir}/modules/multiqc"

/* 
 * main script flow
 */
workflow {
  read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true ) 
  report_nm = channel.value("multiqc_rsem_report.html")
  RNASEQ_STAR_RSEM( params.star_index_dir, params.rsem_reference_dir, read_pairs_ch )
  MULTIQC(report_nm, RNASEQ_STAR_RSEM.out )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.outdir}/multiqc_rsem_report.html\n" : "Oops .. something went wrong" )
}
