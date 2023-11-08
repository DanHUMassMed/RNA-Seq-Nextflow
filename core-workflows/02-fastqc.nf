#!/usr/bin/env nextflow 

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 fastq_paired : ${params.fastq_paired}
 results_dir  : ${params.results_dir}
 """

// import modules
include { FASTQC; FASTQC_SINGLE } from "${launchDir}/modules/fastqc"
include { MULTIQC } from "${launchDir}/modules/multiqc"

/* 
 * Run FastQC on each of the Fastq files
 * Run MultiQC to aggregate all the individual FatsQC Reports
 */

workflow {
  read_pairs_ch = channel.fromFilePairs( params.fastq_paired, checkIfExists: true ) 
  report_nm = channel.value("multiqc_report.html")
  FASTQC(read_pairs_ch)
  MULTIQC(report_nm, FASTQC.out.collect()  )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.results_dir}/multiqc_report.html\n" : "Oops .. something went wrong" )
}
