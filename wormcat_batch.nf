#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

params.excel_file = "${baseDir}/data/Murphy_TS.xlsx"
params.outdir = "results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 excel_file   : ${params.excel_file}
 output_dir       : ${params.output_dir}
 outdir            : ${params.outdir}
 base_dir          : ${baseDir}
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
