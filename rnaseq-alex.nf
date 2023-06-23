#!/usr/bin/env nextflow 

/* 
 * enables modules 
 */
nextflow.enable.dsl = 2

/*
 * Default pipeline parameters. They can be overriden on the command line eg.
 * given `params.foo` specify on the run command line `--foo some_value`.
 */

params.reads = "${baseDir}/data/alex_byrne/input_data/Bi*_{1,2}.fq"
params.star_index_dir="${baseDir}/results/star"
params.rsem_reference_dir = "${baseDir}/results/rsem/WBPS18"
params.outdir = "results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 reads              : ${params.reads}
 star_index_dir     : ${params.star_index_dir}
 rsem_reference_dir : ${params.rsem_reference_dir}
 outdir             : ${params.outdir}
 base_dir           : ${baseDir}
 """

// import modules
include { RNASEQ_STAR_RSEM } from './modules/sub-workflow/rnaseq-star-rsem'
include { MULTIQC } from './modules/multiqc'

/* 
 * main script flow
 */
workflow {
  read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true ) 
  RNASEQ_STAR_RSEM( params.star_index_dir, params.rsem_reference_dir, read_pairs_ch )
  MULTIQC( RNASEQ_STAR_RSEM.out )
}

