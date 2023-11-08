#!/usr/bin/env nextflow 

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 deseq_up_down_dir : ${params.deseq_up_down_dir}
 results_dir       : ${params.results_dir}
 """

// import modules
include { WORMCAT_CSV } from "${launchDir}/modules/wormcat"

/* 
 * main script flow
 */
workflow { 
  csv_dir_ch = channel.fromPath( params.deseq_up_down_dir, type: 'dir' )
  WORMCAT_CSV( csv_dir_ch )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Your output can be found here --> ${params.results_dir}\n" : "Oops .. something went wrong" )
}
