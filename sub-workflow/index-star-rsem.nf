
// import modules
include { STAR_INDEX } from '../modules/star'
include { RSEM_INDEX } from '../modules/rsem'

workflow INDEX_STAR_RSEM {
  take:
    genome_file
    annotation_file

  main:
    STAR_INDEX( genome_file, annotation_file )
    RSEM_INDEX( genome_file, annotation_file )
}
