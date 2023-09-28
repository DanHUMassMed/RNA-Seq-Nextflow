params.outdir = 'results'

process TRIM_SLIDING_WINDOW {
    container "danhumassmed/picard-trimmomatic:1.0.1"

    input:
    tuple val(sample_id), path(reads)
    val data_root
    val dir_suffix

    script:
    """
    trimmomatic.sh ${reads[0]} ${reads[1]} ${data_root} ${dir_suffix}
    """

    output:
    path "trim_${dir_suffix}" 

}

process TRIM_AGGREGATE {
    container "danhumassmed/picard-trimmomatic:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    path('*')

    script:
    """
    trimmomatic_aggregate.sh
    """

    output:
    path "trimmed" 

}

