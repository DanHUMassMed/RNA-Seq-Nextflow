#!/usr/bin/env nextflow 


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 data_remote : ${params.data_remote}
 data_for    : ${params.data_for}
 data_dir    : ${params.data_dir}
 results_dir : ${params.results_dir}
 """

/* 
 * This workflow pulls fastq files from Dropbox and stages them on the HPC for downstream processing
 * If MD5 Files are included in the directories with the fastq files, an MD5 check will be made, and a report will be generated
 */

include { GET_DROPBOX_DATA } from "${launchDir}/modules/de-seq-tools"
include { CHECK_MD5 } from "${launchDir}/modules/de-seq-tools"

workflow {
  GET_DROPBOX_DATA(params.data_remote, params.data_for)
  CHECK_MD5(GET_DROPBOX_DATA.out.collect())
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! The data is avialable --> ${params.data_dir}\n" : "Oops .. something went wrong" )
}


