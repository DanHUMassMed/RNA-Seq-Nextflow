#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

/*
 * Create Salmon files based on a specific Wormbase Release
 * NOTE: Pre-creation on the index will accelerate pipeline runs 
 */

params.wormbase_version="WS289"
params.annotation_file = "${baseDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.canonical_geneset.gtf"
params.genome_file = "${baseDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.genomic.fa"
params.transcripts_file = "${baseDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.mRNA_transcripts.fa"
params.outdir = "results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 annotation_file   : ${params.annotation_file}
 genome_file       : ${params.genome_file}
 transcripts_file  : ${params.transcripts_file}
 outdir            : ${params.outdir}
 base_dir          : ${baseDir}
 """

// import modules
include { INDEX_SALMON } from './modules/sub-workflow/index-salmon'

/* 
 * main script flow
 */
workflow {
  INDEX_SALMON( params.annotation_file, params.genome_file, params.transcripts_file )
}

