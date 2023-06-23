process RSEM_INDEX {
    container "danhumassmed/star-rsem:1.0.0"
    publishDir params.outdir, mode:'copy'

    input:
    path fasta_file
    path gtf_file 

    output:
    path 'rsem' 

    script:
    """
    mkdir -p ./rsem
    rsem-prepare-reference \
        --gtf ${gtf_file} \
        ${fasta_file} \
        ./rsem/WBPS18
    """
}

process RSEM_QUANTIFY {
    container "danhumassmed/star-rsem:1.0.0"
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
            ${rsem_reference_dir} \
            ./rsem_expression_${pair_id}/rsem_${pair_id} >& \
            ./rsem_expression_${pair_id}/rsem_${pair_id}.log

    """
}

