#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

/*
 * Create STAR and rsem index files based on a specific Wormbase Release
 * NOTE: Pre-creation of the index will accelerate pipeline runs 
 */

params.wormbase_version="WS289"
params.annotation_file = "${projectDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.canonical_geneset.gtf"
params.genome_file = "${projectDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.genomic.fa"
params.outdir = "${projectDir}/results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 genome_file     : ${params.genome_file}
 annotation_file : ${params.annotation_file}
 outdir          : ${params.outdir}
 project_dir     : ${projectDir}
 launch_dir      : ${launchDir}
 """

// import modules
include { INDEX_STAR_RSEM } from "${launchDir}/modules/sub-workflow/index-star-rsem"

/* 
 * main script flow
 */
workflow {
  INDEX_STAR_RSEM( params.genome_file, params.annotation_file )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Index files can be found here --> ${params.outdir}\n" : "Oops .. something went wrong" )
}
