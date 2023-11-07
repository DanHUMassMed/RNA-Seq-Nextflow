#!/usr/bin/env nextflow 

// nextflow run pipelines/alex_byrne_lab/06-overview-report-alex.nf -bg -N daniel.higgins@umassmed.edu


nextflow.enable.dsl = 2

/*
 * RNA SEQ Pipeline 
 */

params.report_config = "${projectDir}/config/Experiment1/experiment1.json"
params.outdir = "${projectDir}/results"


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 report_config : ${params.report_config}
 outdir        : ${params.outdir}
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
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.outdir}/overview_report.pdf\n" : "Oops .. something went wrong" )
}
