params.outdir = 'results'

process FASTQC {
    tag "FASTQC on $sample_id"
    container 'danhumassmed/fastqc-multiqc:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    tuple val(sample_id), path(reads)

    output:
    path "fastqc_${sample_id}_logs" 

    script:
    """
    mkdir fastqc_${sample_id}_logs
    fastqc -o fastqc_${sample_id}_logs -f fastq -q ${reads}
    """
}
