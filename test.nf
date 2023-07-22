#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

/*
 * Test Workflow
 * NOT USED
 */

params.input_path = "${baseDir}/results"
params.tx2gene = "${baseDir}/results/salmon_transcripts/tx2gene.tsv"
params.counts_method = "lengthScaledTPM"
params.outdir = "results"

log.info """\
 TEST - N F   P I P E L I N E
 ===================================
 input_path    : ${params.input_path}
 tx2gene       : ${params.tx2gene}
 counts_method : ${params.counts_method}
 """

// import modules
include { TXIMPORT_COUNTS } from './modules/de-seq-tools'
include { DEBROWSER } from './modules/debrowser'

/* 
 * main script flow
 */
// workflow {
//   dummy_data = channel.fromPath("DUMMY_DATA")
//   TXIMPORT_COUNTS( dummy_data, params.input_path, params.tx2gene,  params.counts_method )
// }

workflow {
  
  DEBROWSER( )
}

