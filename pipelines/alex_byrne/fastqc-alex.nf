#!/usr/bin/env nextflow 

// nextflow run pipelines/alex_byrne/fastqc-alex.nf -resume -bg -N daniel.higgins@umassmed.edu


nextflow.enable.dsl = 2

/*
 * RNA SEQ Pipeline 
 */

params.reads = "${projectDir}/results/trimmed/**/*_{1,2}.fq.gz"
params.outdir = "${projectDir}/results"


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 reads              : ${params.reads}
 outdir             : ${params.outdir}
 """

// import modules
include { FASTQC; FASTQC_SINGLE } from "${launchDir}/modules/fastqc"
include { MULTIQC } from "${launchDir}/modules/multiqc"

/* 
 * main script flow
 */
workflow {
  read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true ) 
  report_nm = channel.value("multiqc_report.html")
  FASTQC(read_pairs_ch)
  MULTIQC(report_nm, FASTQC.out.collect()  )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.outdir}/multiqc_report.html\n" : "Oops .. something went wrong" )
}
