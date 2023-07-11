#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

/*
 * Create STAR and rsem index files based on a specific Wormbase Release
 * NOTE: Pre-creation on the index will accelerate pipeline runs 
 */

params.wormbase_version="WS288"
params.annotation_file = "${baseDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.canonical_geneset.gtf"
params.genome_file = "${baseDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.genomic.fa"
params.outdir = "results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 genome_file     : ${params.genome_file}
 annotation_file : ${params.annotation_file}
 outdir          : ${params.outdir}
 base_dir        : ${baseDir}
 """

// import modules
include { INDEX_STAR_RSEM } from './modules/sub-workflow/index-star-rsem'

/* 
 * main script flow
 */
workflow {
  INDEX_STAR_RSEM( params.genome_file, params.annotation_file )
}
