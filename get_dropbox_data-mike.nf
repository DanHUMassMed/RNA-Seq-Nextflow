#!/usr/bin/env nextflow 

/* 
 * enables modules 
 */
nextflow.enable.dsl = 2

/*
 * RNA SEQ Pipeline optimized for Alex Byrne 
 */

params.data_remote="Francis lab_KB_wholeworm RNAseq data_March 2023_Share AW lab/August 2023 experiment"
params.data_local="data/mike_francis"
params.outdir = "results"

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

include { GET_DROPBOX_DATA } from './modules/de-seq-tools'
include { CHECK_MD5 } from './modules/de-seq-tools'

workflow {
  GET_DROPBOX_DATA(params.data_remote, params.data_local)
  CHECK_MD5(GET_DROPBOX_DATA.out.data_local_dir)
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${baseDir}/${params.outdir}/md5_report.html\n" : "Oops .. something went wrong" )
}
