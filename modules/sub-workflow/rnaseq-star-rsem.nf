params.outdir = 'results'


include { FASTQC } from '../fastqc'
include { STAR_ALIGN } from '../star'
include { RSEM_QUANTIFY; RSEM_SUMMARY } from '../rsem'

workflow RNASEQ_STAR_RSEM {
  take:
    star_index_dir
    rsem_reference_dir
    read_pairs_ch
 
  main: 
    FASTQC(read_pairs_ch)
    STAR_ALIGN(star_index_dir, read_pairs_ch)
    RSEM_QUANTIFY(rsem_reference_dir,STAR_ALIGN.out.bam_file)
    RSEM_SUMMARY(RSEM_QUANTIFY.out.collect())
  emit: 
     RSEM_QUANTIFY.out | concat(STAR_ALIGN.out.star_align_dir) | concat(FASTQC.out) |collect

}