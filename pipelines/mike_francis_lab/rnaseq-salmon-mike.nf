#!/usr/bin/env nextflow 

// nextflow run pipelines/mike_francis/rnaseq-salmon-mike.nf -resume -bg -N daniel.higgins@umassmed.edu

/* 
 * enables modules 
 */
nextflow.enable.dsl = 2


/*
 * RNA SEQ Pipeline EVALUTION
 * NOT CURRENTLY USED
 */

//params.reads = "${projectDir}/data/Experiment3/**/*_{1,2}.fq.gz"
params.reads = "${projectDir}/results/trimmed/**/*_{1,2}.fq.gz"

params.salmon_index = "${launchDir}/pipelines/shared/results/salmon_index"
params.tx2gene = "${launchDir}/pipelines/shared/results/salmon_transcripts/tx2gene.tsv"
params.counts_method = "lengthScaledTPM"

params.outdir = "${projectDir}/results"


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 reads         : ${params.reads}
 salmon_index  : ${params.salmon_index}
 tx2gene       : ${params.tx2gene}
 counts_method : ${params.counts_method}
 outdir        : ${params.outdir}
 """

// import modules
include { RNASEQ_SALMON } from "${launchDir}/modules/subworkflows/rnaseq-salmon"
include { MULTIQC } from "${launchDir}/modules/multiqc"

/* 
 * main script flow
 */
workflow {
  read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true ) 
  report_nm = channel.value("multiqc_salmon_report.html")
  RNASEQ_SALMON( params.salmon_index, read_pairs_ch, params.tx2gene, params.counts_method)
  MULTIQC(report_nm, RNASEQ_SALMON.out )
}

/* 
 * completion handler
 */
workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.outdir}/multiqc_salmon_report.html\n" : "Oops .. something went wrong" )
}
