params.outdir = 'results'

include { SALMON_QUANTIFY } from '../salmon'
include { FASTQC } from '../fastqc'

workflow RNASEQ_SALMON {
  take:
    salmon_index
    read_pairs_ch
 
  main: 
    //FASTQC(read_pairs_ch)
    SALMON_QUANTIFY(salmon_index, read_pairs_ch)

  emit: 
     SALMON_QUANTIFY.out | collect
}