
// import modules
include { STAR_INDEX } from '../star'
include { RSEM_INDEX } from '../rsem'

workflow INDEX_STAR_RSEM {
  take:
    genome_file
    annotation_file

  main:
    STAR_INDEX( genome_file, annotation_file )
    RSEM_INDEX( genome_file, annotation_file )
}
