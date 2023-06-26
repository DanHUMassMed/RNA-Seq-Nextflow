#!/usr/bin/env nextflow 

/* 
 * enables modules 
 */
nextflow.enable.dsl = 2



params.reads = "${baseDir}/data/alex_byrne/input_data/*_{1,2}.fq"
params.salmon_index = "${baseDir}/results/salmon_index"
params.outdir = "results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 salmon_index   : ${params.salmon_index}
 reads        : ${params.reads}
 outdir       : ${params.outdir}
 base_dir     : ${baseDir}
 """

// import modules
include { RNASEQ_SALMON } from './modules/sub-workflow/rnaseq-salmon'
include { MULTIQC } from './modules/multiqc'

/* 
 * main script flow
 */
workflow {
  read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true ) 
  RNASEQ_SALMON( params.salmon_index, read_pairs_ch )
  MULTIQC( RNASEQ_SALMON.out )
}

/* 
 * completion handler
 */
workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> $params.outdir/multiqc_report.html\n" : "Oops .. something went wrong" )
}
