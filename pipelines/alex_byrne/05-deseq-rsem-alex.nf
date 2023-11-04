#!/usr/bin/env nextflow 

// nextflow run pipelines/alex_byrne/deseq-rsem-alex.nf -bg -N daniel.higgins@umassmed.edu


nextflow.enable.dsl = 2

/*
 * RNA SEQ Pipeline 
 */

params.deseq_meta = "${projectDir}/data/Experiment1/deseq_meta/run_*.csv"
params.counts = "${projectDir}/results/rsem_summary/genes_expression_expected_count.tsv"
params.low_count_max = 10
params.outdir = "${projectDir}/results"


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 deseq_meta    : ${params.deseq_meta}
 counts        : ${params.counts}
 low_count_max : ${params.low_count_max}
 outdir        : ${params.outdir}
 """

// import modules
include { LOW_COUNT_FILTER; DESEQ_EXEC } from "${launchDir}/modules/de-seq-tools"

/* 
 * main script flow
 */
workflow {
  counts_ch = channel.value( params.counts ) 
  deseq_meta_ch = channel.fromPath( params.deseq_meta, checkIfExists: true ) 
  LOW_COUNT_FILTER( counts_ch, params.low_count_max )
  DESEQ_EXEC( LOW_COUNT_FILTER.out.low_count_file, deseq_meta_ch )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.outdir}/multiqc_rsem_report.html\n" : "Oops .. something went wrong" )
}
