params.outdir = 'results'

process STAR_INDEX {
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    path fasta_file
    path gtf_file 

    output:
    path 'star_index' 

    script:
    """
    STAR --runThreadN $task.cpus \
        --runMode genomeGenerate \
        --genomeDir ./star_index \
        --genomeSAindexNbases 12 \
        --genomeFastaFiles ${fasta_file} \
        --sjdbGTFfile ${gtf_file}
    """
}

process STAR_ALIGN {
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    path star_index_dir
    tuple val(pair_id), path(reads)  

    output:
    tuple val(pair_id), path("star_aligned_${pair_id}/star_${pair_id}Aligned.toTranscriptome.out.bam") , emit: bam_file
    path "star_aligned_${pair_id}", emit: star_align_dir

    script:
    """
    mkdir -p ./star_aligned_${pair_id}
    STAR --runThreadN $task.cpus \
        --genomeDir ${star_index_dir} \
        --readFilesIn ${reads[0]} ${reads[1]} \
        --outSAMtype BAM Unsorted \
        --quantMode TranscriptomeSAM \
        --outFileNamePrefix ./star_aligned_${pair_id}/star_${pair_id}
    """
}