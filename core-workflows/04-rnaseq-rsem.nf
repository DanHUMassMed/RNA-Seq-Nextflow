#!/usr/bin/env nextflow 


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 fastq_paired       : ${params.fastq_paired}
 fastq_single       : ${params.fastq_single}
 star_index_dir     : ${params.star_index_dir}
 rsem_reference_dir : ${params.rsem_reference_dir}
 results_dir        : ${params.results_dir}
 """

// import modules
include { RNASEQ_STAR_RSEM; RNASEQ_STAR_RSEM_SINGLE } from "${launchDir}/sub-workflow/rnaseq-star-rsem"
include { MULTIQC } from "${launchDir}/modules/multiqc"

/* 
 * main script flow
 */
workflow {
  if(params.fastq_paired) {
    read_pairs_ch = channel.fromFilePairs( params.fastq_paired, checkIfExists: true ) 
    report_nm = channel.value("multiqc_rsem_report.html")
    RNASEQ_STAR_RSEM( params.star_index_dir, params.rsem_reference_dir, read_pairs_ch )
    MULTIQC(report_nm, RNASEQ_STAR_RSEM.out )
  }

  if(params.fastq_single) {
    read_ch = channel.fromPath( params.fastq_single, checkIfExists: true ) 
    report_nm = channel.value("multiqc_rsem_report.html")
    RNASEQ_STAR_RSEM_SINGLE( params.star_index_dir, params.rsem_reference_dir, read_ch )
    MULTIQC(report_nm, RNASEQ_STAR_RSEM_SINGLE.out )
  }

}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.results_dir}/multiqc_rsem_report.html\n" : "Oops .. something went wrong" )
}
