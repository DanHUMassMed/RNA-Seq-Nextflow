#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

params.reads = "${baseDir}/data/mike_francis/**/*_{1,2}.fq.gz"
params.data_root="mike_francis"
params.outdir = "results"

log.info """\
 TRIMMOMATIC - N F   P I P E L I N E
 ===================================
 reads        : ${params.reads}
 outdir       : ${params.outdir}
 base_dir     : ${baseDir}
 """

// import modules
include { TRIM_SLIDING_WINDOW; TRIM_AGGREGATE } from './modules/trimmomatic'

/* 
 * main script flow
 */
workflow {
  read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true )
  dir_suffix = channel.of(1..100)
  TRIM_SLIDING_WINDOW( read_pairs_ch, params.data_root, dir_suffix )
  TRIM_AGGREGATE(TRIM_SLIDING_WINDOW.out.collect() )
}

/* 
 * completion handler
 */
workflow.onComplete {
  def msg = """\
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """
        .stripIndent()

    sendMail(to: 'daniel.higgins@umassmed.edu', subject: 'TRIMMOMATIC completed', body: msg)

	log.info ( workflow.success ? "\nDone! The results can be found in --> ${baseDir}/${params.outdir}/trimmed\n" : "Oops .. something went wrong" )
}
