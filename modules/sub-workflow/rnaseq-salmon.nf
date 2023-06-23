params.outdir = 'results'

include { INDEX } from '../salmon'
include { QUANT } from '../salmon'
include { FASTQC } from '../fastqc'

workflow RNASEQ_SALMON {
  take:
    transcriptome
    read_pairs_ch
 
  main: 
    INDEX(transcriptome)
    FASTQC(read_pairs_ch)
    QUANT(INDEX.out, read_pairs_ch)

  emit: 
     QUANT.out | concat(FASTQC.out) | collect
}