#!/usr/bin/env nextflow 

/* 
 * enables modules 
 */
nextflow.enable.dsl = 2

/*
 * RNA SEQ Pipeline optimized for Alex Byrne 
 */

// rclone lsd remote:"Francis lab_KB_wholeworm RNAseq data_March 2023_Share AW lab"
// rclone lsd remote:"SamLiu_ Francis lab September 2023"

//params.data_remote="Francis lab_KB_wholeworm RNAseq data_March 2023_Share AW lab/August 2023 experiment"
//params.data_remote="Francis lab_KB_wholeworm RNAseq data_March 2023_Share AW lab/March 2023 experiment"
params.data_remote="SamLiu_ Francis lab September 2023"
params.data_local="Experiment3"
params.outdir = "${projectDir}/data"
params.reportdir = "${params.outdir}/${params.data_local}"



log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 data_remote    : ${params.data_remote}
 outdir         : ${params.outdir}
 project_dir    : ${projectDir}
 launch_dir     : ${launchDir}
 """

/* 
 * main script flow
 */

include { GET_DROPBOX_DATA } from "${launchDir}/modules/de-seq-tools"
include { CHECK_MD5 } from "${launchDir}/modules/de-seq-tools"

workflow {
  GET_DROPBOX_DATA(params.data_remote, params.data_local)
  //CHECK_MD5(GET_DROPBOX_DATA.out.collect())
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! The data is avialable --> ${params.reportdir}\n" : "Oops .. something went wrong" )
}


