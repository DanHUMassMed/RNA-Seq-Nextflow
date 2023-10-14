
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
        --readFilesIn <(gzip -dc ${reads[0]}) <(gzip -dc ${reads[1]}) \
        --outSAMtype BAM Unsorted \
        --quantMode TranscriptomeSAM \
        --outFileNamePrefix ./star_aligned_${pair_id}/star_${pair_id}
    """
}

process STAR_ALIGN_SINGLE {
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    path star_index_dir
    path read_single

    output:
    path("star_aligned_${read_single.getName().split("\\.")[0]}/star_${read_single.getName().split("\\.")[0]}Aligned.toTranscriptome.out.bam") , emit: bam_file
    path "star_aligned_${read_single.getName().split("\\.")[0]}", emit: star_align_dir

    script:
    def read_id = read_single.getName().split("\\.")[0]
    """
    mkdir -p ./star_aligned_${read_id}
    STAR --runThreadN $task.cpus \
        --genomeDir ${star_index_dir} \
        --readFilesIn <(gzip -dc ${read_single}) \
        --outSAMtype BAM Unsorted \
        --quantMode TranscriptomeSAM \
        --outFileNamePrefix ./star_aligned_${read_id}/star_${read_id}
    """
}