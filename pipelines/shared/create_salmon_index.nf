#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

/*
 * Create Salmon files based on a specific Wormbase Release
 * NOTE: Pre-creation on the index will accelerate pipeline runs 
 */

params.wormbase_version="WS289"
params.annotation_file = "${projectDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.canonical_geneset.gtf"
params.genome_file = "${projectDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.genomic.fa"
params.transcripts_file = "${projectDir}/data/c_elegans.PRJNA13758.${params.wormbase_version}.mRNA_transcripts.fa"
params.outdir = "${projectDir}/results"

log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 annotation_file   : ${params.annotation_file}
 genome_file       : ${params.genome_file}
 transcripts_file  : ${params.transcripts_file}
 outdir            : ${params.outdir}
 project_dir       : ${projectDir}
 launch_dir        : ${launchDir}
 """

// import modules
include { INDEX_SALMON } from "${launchDir}/modules/subworkflows/index-salmon"

/* 
 * main script flow
 */
workflow {
  INDEX_SALMON( params.annotation_file, params.genome_file, params.transcripts_file )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Index files can be found here --> ${params.outdir}\n" : "Oops .. something went wrong" )
}

