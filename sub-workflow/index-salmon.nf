
// import modules
include { DECOY_TRANSCRIPTOME } from '../modules/bedtools'
include { SALMON_INDEX } from '../modules/salmon'
include { TX2GENE } from '../modules/de-seq-tools'

workflow INDEX_SALMON {
  take:
    annotation_file
    genome_file
    transcripts_file
    

  main:
    DECOY_TRANSCRIPTOME( annotation_file, genome_file, transcripts_file)
    TX2GENE( DECOY_TRANSCRIPTOME.out.gentrome_fa )
    SALMON_INDEX( DECOY_TRANSCRIPTOME.out.gentrome_fa )
}
