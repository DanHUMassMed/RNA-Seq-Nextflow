params.outdir = 'results'

// import modules
include { STAR_INDEX } from '../star'
include { RSEM_INDEX } from '../rsem'

workflow INDEX_STAR_RSEM {
  take:
    fasta_file
    gtf_file

  main:
    STAR_INDEX( fasta_file, gtf_file )
    RSEM_INDEX( fasta_file, gtf_file )
}
