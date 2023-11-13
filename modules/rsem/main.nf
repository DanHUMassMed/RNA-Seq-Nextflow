process RSEM_INDEX {
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.results_dir, mode:'copy'

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
    publishDir params.results_dir, mode:'copy'

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

process RSEM_QUANTIFY_SINGLE {
    tag "RSEM_QUANTIFY_SINGLE on ${bam_file}"
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.results_dir, mode:'copy'

    input:
    val rsem_reference_dir
    path bam_file

    output:
    path "rsem_expression_${bam_file.getName().substring(5,bam_file.getName().length()-31)}"

    script:
    """
    mkdir -p ./rsem_expression_${bam_file.getName().substring(5,bam_file.getName().length()-31)}
    rsem-calculate-expression \
        --num-threads $task.cpus \
        --time \
        --no-bam-output \
        --alignments \
            ${bam_file} \
            ${rsem_reference_dir}/rsem \
            ./rsem_expression_${bam_file.getName().substring(5,bam_file.getName().length()-31)}/rsem_${bam_file.getName().substring(5,bam_file.getName().length()-31)} >& \
            ./rsem_expression_${bam_file.getName().substring(5,bam_file.getName().length()-31)}/rsem_${bam_file.getName().substring(5,bam_file.getName().length()-31)}.log

    """
}


process RSEM_SUMMARY {
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.results_dir, mode:'copy'

    input:
    path('rsem_expression_*')

    output:
    path "rsem_summary" 

    script:
    """
    mkdir -p rsem_summary
    cd rsem_summary
    expression_summary.py  --expression-type rsem --input-path ..
    """
}

process GET_WORMBASE_DATA {
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.data_dir, mode:'copy'

    input:
    val wormbase_version

    output:
    path "wormbase", emit: wormbase_dir
    path "wormbase/c_elegans.PRJNA13758.${wormbase_version}.canonical_geneset.gtf", emit: annotation_file
    path "wormbase/c_elegans.PRJNA13758.${params.wormbase_version}.genomic.fa", emit: genome_file
    path "wormbase/c_elegans.PRJNA13758.${params.wormbase_version}.mRNA_transcripts.fa", emit: transcripts_file


    script:
    """
    mkdir -p wormbase
    cd wormbase
    wormbase_download.sh ${wormbase_version}
    """
}
