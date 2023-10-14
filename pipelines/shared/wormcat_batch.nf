#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

/*
 * Wormcat Batch Test Scripts
 * Used to confirm proper execution of Wormcat with Nextflow
 */

params.excel_file = "${projectDir}/data/Murphy_TS.xlsx"
params.outdir = "${projectDir}/results"

log.info """\
 WORMCAT BATCH - N F   P I P E L I N E
 ===================================
 excel_file   : ${params.excel_file}
 outdir       : ${params.outdir}
 project_dir     : ${projectDir}
 launch_dir      : ${launchDir}
 """

// import modules
include { WORMCAT } from "${launchDir}/modules/wormcat"

/* 
 * main script flow
 */
workflow {
  excel_file = Channel.fromPath( params.excel_file )
  WORMCAT( excel_file )
}

/* 
 * completion handler
 */
workflow.onComplete {
	log.info ( workflow.success ? "\nDone! The results can be found in --> ${params.outdir}/wormcat_out\n" : "Oops .. something went wrong" )
}
