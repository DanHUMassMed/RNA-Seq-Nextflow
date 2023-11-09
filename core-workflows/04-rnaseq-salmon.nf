#!/usr/bin/env nextflow 


/*
 * RNA SEQ Pipeline EVALUTION 
 * NOT CURRENTLY USED
 */


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 salmon_index_dir : ${params.salmon_index_dir}
 fastq_paired     : ${params.fastq_paired}
 fastq_single     : ${params.fastq_single}
 tx2gene          : ${params.tx2gene}
 counts_method    : ${params.counts_method}
 results_dir      : ${params.results_dir}
 """

// import modules
include { RNASEQ_SALMON; RNASEQ_SALMON_SINGLE } from "${launchDir}/sub-workflow/rnaseq-salmon"
include { MULTIQC } from "${launchDir}/modules/multiqc"

/* 
 * main script flow
 */
workflow {
  if(params.fastq_paired) {
      read_pairs_ch = channel.fromFilePairs( params.fastq_paired, checkIfExists: true ) 
      report_nm = channel.value("multiqc_salmon_report.html")
      RNASEQ_SALMON( params.salmon_index_dir, read_pairs_ch, params.tx2gene, params.counts_method)
      MULTIQC(report_nm, RNASEQ_SALMON.out )
  }

  if(params.fastq_single) {
      read_ch = channel.fromPath( params.fastq_single, checkIfExists: true ) 
      report_nm = channel.value("multiqc_salmon_report.html")
      RNASEQ_SALMON_SINGLE( params.salmon_index_dir, read_ch, params.tx2gene, params.counts_method)
      MULTIQC(report_nm, RNASEQ_SALMON_SINGLE.out )
  }
}

/* 
 * completion handler
 */
workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.results_dir}/multiqc_salmon_report.html\n" : "Oops .. something went wrong" )
}
