#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2


log.info """\
 P A R A M S -- CREATE SALMON INDEX
 =====================================
 wormbase_version : ${params.wormbase_version}
 data_dir         : ${params.data_dir}
 results_dir      : ${params.results_dir}
 """

// import modules
include { GET_WORMBASE_DATA   } from '../modules/rsem'
include { DECOY_TRANSCRIPTOME } from '../modules/bedtools'
include { SALMON_INDEX        } from '../modules/salmon'
include { TX2GENE             } from '../modules/de-seq-tools'

/* 
 * main script flow
 */
workflow CREATE_SALMON_INDEX {
    GET_WORMBASE_DATA( params.wormbase_version )
    DECOY_TRANSCRIPTOME( GET_WORMBASE_DATA.out.genome_file, GET_WORMBASE_DATA.out.annotation_file, GET_WORMBASE_DATA.out.transcripts_file )
    TX2GENE( DECOY_TRANSCRIPTOME.out.gentrome_fa )
    SALMON_INDEX( DECOY_TRANSCRIPTOME.out.gentrome_fa )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Index files can be found here --> ${params.results_dir}\n" : "Oops .. something went wrong" )
}
