#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

params.gtf_file = "${baseDir}/data/caenorhabditis_elegans.PRJNA13758.WBPS18.canonical_geneset.gtf"
params.fasta_file = "${baseDir}/data/caenorhabditis_elegans.PRJNA13758.WBPS18.genomic.fa"
params.outdir = "results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 fasta_file   : ${params.fasta_file}
 gtf_file     : ${params.gtf_file}
 outdir       : ${params.outdir}
 base_dir     : ${baseDir}
 """

// import modules
include { STAR_INDEX } from './modules/star'
include { RSEM_INDEX } from './modules/rsem'

/* 
 * main script flow
 */
workflow {
  STAR_INDEX( params.fasta_file, params.gtf_file )
  RSEM_INDEX( params.fasta_file, params.gtf_file )
}

