#!/usr/bin/env nextflow 

/* 
 * enables modules 
 */
nextflow.enable.dsl = 2


/*
 * RNA SEQ Pipeline
 * NOT CURRENTLY USED
 */

params.reads = "${baseDir}/data/amy_walker/*/*.fq.gz"
params.salmon_index = "${baseDir}/results/salmon_index"

params.input_path = "${baseDir}/results"
params.tx2gene = "${baseDir}/results/salmon_transcripts/tx2gene.tsv"
params.counts_method = "lengthScaledTPM"

params.outdir = "results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 salmon_index : ${params.salmon_index}
 reads        : ${params.reads}
 outdir       : ${params.outdir}
 base_dir     : ${baseDir}
 """

// import modules
include { RNASEQ_SALMON_SINGLE } from './modules/sub-workflow/rnaseq-salmon'
include { MULTIQC } from './modules/multiqc'

/* 
 * main script flow
 */
workflow {
  reads_ch = channel.fromPath( params.reads, checkIfExists: true ) 
  report_nm = channel.value("multiqc_salmon_report.html")
  RNASEQ_SALMON_SINGLE( params.salmon_index, reads_ch, params.input_path, params.tx2gene, params.counts_method)
  MULTIQC(report_nm, RNASEQ_SALMON_SINGLE.out )
}

/* 
 * completion handler
 */
workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${baseDir}/${params.outdir}/multiqc_salmon_report.html\n" : "Oops .. something went wrong" )
}
