#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

/*
 * Wormcat Batch Test Scripts
 * Used to confirm proper execution of Wormcat with Nextflow
 */

params.excel_file = "${baseDir}/data/Murphy_TS.xlsx"
params.outdir = "results"

log.info """\
 WORMCAT BATCH - N F   P I P E L I N E
 ===================================
 excel_file   : ${params.excel_file}
 output_dir   : ${params.output_dir}
 outdir       : ${params.outdir}
 base_dir     : ${baseDir}
 """

// import modules
include { WORMCAT } from './modules/wormcat'

/* 
 * main script flow
 */
workflow {
  excel_file = Channel.fromPath( params.excel_file )
  WORMCAT( excel_file )
}

