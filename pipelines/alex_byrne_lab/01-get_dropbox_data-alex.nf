#!/usr/bin/env nextflow 

// nextflow run pipelines/alex_byrne_lab/01-get_dropbox_data-alex.nf -bg -N daniel.higgins@umassmed.edu
// rclone lsl remote:"RNA-seq/daf19 & tir1 RNAseq Working Files" --human-readable| sed 's/\.000000000//g'

nextflow.enable.dsl = 2

/*
 * Stage Dropbox Data to HPC
 */

params.data_remote="RNA-seq/daf19 & tir1 RNAseq Working Files"
params.data_local="Experiment1"
params.outdir = "${projectDir}/data"
params.reportdir = "${projectDir}/results"



log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 data_remote : ${params.data_remote}
 data_local  : ${params.data_local}
 outdir      : ${params.outdir}
 reportdir   : ${params.reportdir}
 """

/* 
 * main script flow
 */

include { GET_DROPBOX_DATA } from "${launchDir}/modules/de-seq-tools"
include { CHECK_MD5 } from "${launchDir}/modules/de-seq-tools"

workflow {
  GET_DROPBOX_DATA(params.data_remote, params.data_local)
  CHECK_MD5(GET_DROPBOX_DATA.out.collect())
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! The data is avialable --> ${params.reportdir}\n" : "Oops .. something went wrong" )
}


