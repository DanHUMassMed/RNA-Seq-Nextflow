#!/usr/bin/env nextflow 

/* 
 * enables modules 
 */
nextflow.enable.dsl = 2

/*
 * RNA SEQ Pipeline optimized for Alex Byrne 
 */

params.reads = "${baseDir}/data/alex_byrne/*/*_{1,2}.fq.gz"
params.star_index_dir="${baseDir}/results/star_index"
params.rsem_reference_dir = "${baseDir}/results/rsem_index"
params.outdir = "results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 reads              : ${params.reads}
 star_index_dir     : ${params.star_index_dir}
 rsem_reference_dir : ${params.rsem_reference_dir}
 outdir             : ${params.outdir}
 base_dir           : ${baseDir}
 """

// import modules
include { RNASEQ_STAR_RSEM } from './modules/sub-workflow/rnaseq-star-rsem'
include { MULTIQC } from './modules/multiqc'

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
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${baseDir}/$params.outdir/multiqc_rsem_report.html\n" : "Oops .. something went wrong" )
}
