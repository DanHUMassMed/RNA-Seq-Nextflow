#!/usr/bin/env nextflow 


log.info """\
 P A R A M S -- RUN OVERVIEW REPORT
 ===================================
 report_config : ${params.report_config}
 results_dir   : ${params.results_dir}
 """

// import modules
include { OVERVIEW_REPORT } from '../modules/fastqc'

/* 
 * main script flow
 */
workflow RUN_OVERVIEW_REPORT { 
  report_config_ch = channel.fromPath( params.report_config, checkIfExists: true ) 
  OVERVIEW_REPORT( report_config_ch )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.results_dir}/overview_report.pdf\n" : "Oops .. something went wrong" )
}
