#!/usr/bin/env nextflow 

// nextflow run pipelines/alex_byrne_lab/06-wormcat-alex.nf -bg -N daniel.higgins@umassmed.edu


nextflow.enable.dsl = 2

/*
 * RNA SEQ Pipeline 
 */

params.csv_dir = "${projectDir}/results/deseq_**/wc_**"
params.outdir = "${projectDir}/results"


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 csv_dir : ${params.csv_dir}
 outdir  : ${params.outdir}
 """

// import modules
include { WORMCAT_CSV } from "${launchDir}/modules/wormcat"

/* 
 * main script flow
 */
workflow { 
  csv_dir_ch = channel.fromPath( params.csv_dir, type: 'dir' )
  WORMCAT_CSV( csv_dir_ch )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Your output can be found here --> ${params.outdir}\n" : "Oops .. something went wrong" )
}
