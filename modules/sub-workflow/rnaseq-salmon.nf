params.outdir = 'results'

include { FASTQC } from '../fastqc'
include { SALMON_QUANTIFY; SALMON_SUMMARY } from '../salmon'
include { TXIMPORT_COUNTS } from '../de-seq-tools'

workflow RNASEQ_SALMON {
  take:
    salmon_index
    read_pairs_ch
    input_path 
    tx2gene
    counts_method
 
  main: 
    FASTQC(read_pairs_ch)
    SALMON_QUANTIFY(salmon_index, read_pairs_ch)
    TXIMPORT_COUNTS(SALMON_QUANTIFY.out.collect(), input_path, tx2gene, counts_method)
  emit: 
     SALMON_QUANTIFY.out | concat(FASTQC.out) | collect
}