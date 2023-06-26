params.outdir = 'results'

// import modules
include { DECOY_TRANSCRIPTOME } from '../bedtools'
include { SALMON_INDEX } from '../salmon'

workflow INDEX_SALMON {
  take:
    annotation_file
    genome_file
    transcripts_file

  main:
    DECOY_TRANSCRIPTOME( annotation_file, genome_file, transcripts_file)
    SALMON_INDEX( DECOY_TRANSCRIPTOME.out.decoy_transcriptome )

}
