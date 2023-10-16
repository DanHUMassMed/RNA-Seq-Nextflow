
process FASTQC {
    tag "FASTQC on $sample_id"
    container 'danhumassmed/qc-tools:1.0.1'
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

process FASTQC_SINGLE {
    tag "FASTQC on ${reads.getName().split("\\.")[0]}"
    container 'danhumassmed/qc-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    path reads

    output:
    path "fastqc_${reads.getName().split("\\.")[0]}_logs" 

    script:
    def file_name_prefix = reads.getName().split("\\.")[0]
    """
    mkdir fastqc_${file_name_prefix}_logs
    fastqc -o fastqc_${file_name_prefix}_logs -f fastq -q ${reads}
    """
}

