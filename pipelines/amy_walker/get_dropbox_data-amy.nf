#!/usr/bin/env nextflow 

// nextflow run pipelines/amy_walker/get_dropbox_data-amy.nf -resume -bg -N daniel.higgins@umassmed.edu
// rclone lsd remote:"staging/RNA_AMY"
/* 
 * enables modules 
 */
nextflow.enable.dsl = 2

/*
 * Stage Dropbox Data to HPC
 rclone lsd remote:delme/RNA_AMY
 */

params.data_remote="staging/RNA_AMY"
params.data_local="Experiment1"
params.outdir = "${projectDir}/data"



log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 data_remote     : ${params.data_remote}
 data_local      : ${params.data_local}
 outdir          : ${params.outdir}
 base_dir        : ${baseDir}
 """

/* 
 * main script flow
 */

include { GET_DROPBOX_DATA } from "${launchDir}/modules/de-seq-tools"
include { CHECK_MD5 } from "${launchDir}/modules/de-seq-tools"

workflow {
  GET_DROPBOX_DATA(params.data_remote, params.data_local)
  CHECK_MD5(GET_DROPBOX_DATA.out.data_local_dir)
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! The data is avialable --> ${params.outdir}\n" : "Oops .. something went wrong" )
}
