#!/usr/bin/env nextflow 


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 report_config : ${params.report_config}
 results_dir   : ${params.results_dir}
 """

// import modules
include { OVERVIEW_REPORT } from "${launchDir}/modules/fastqc"

/* 
 * main script flow
 */
workflow { 
  report_config_ch = channel.fromPath( params.report_config, checkIfExists: true ) 
  OVERVIEW_REPORT( report_config_ch )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.results_dir}/overview_report.pdf\n" : "Oops .. something went wrong" )
}
