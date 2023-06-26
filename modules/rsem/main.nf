process RSEM_INDEX {
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    path genome_file
    path annotation_file 

    output:
    path 'rsem_index' 

    script:
    """
    mkdir -p ./rsem_index
    rsem-prepare-reference \
        --gtf ${annotation_file} \
        ${genome_file} \
        ./rsem_index/rsem
    """
}

process RSEM_QUANTIFY {
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    val rsem_reference_dir
    tuple val(pair_id), path(bam_file)

    output:
    path "rsem_expression_${pair_id}"

    script:
    """
    mkdir -p ./rsem_expression_${pair_id}
    rsem-calculate-expression \
        --num-threads $task.cpus \
        --paired-end \
        --time \
        --no-bam-output \
        --alignments \
            ${bam_file} \
            ${rsem_reference_dir}/rsem \
            ./rsem_expression_${pair_id}/rsem_${pair_id} >& \
            ./rsem_expression_${pair_id}/rsem_${pair_id}.log

    """
}

process RSEM_SUMMARY {
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    path('*')

    output:
    path "rsem_summary" 

    script:
    """
    mkdir -p rsem_summary
    cd rsem_summary
    rsem_summary.py "${baseDir}/${params.outdir}"
    """
}
