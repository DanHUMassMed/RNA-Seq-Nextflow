process STAR_INDEX {
    container "danhumassmed/star-rsem:1.0.0"
    publishDir params.outdir, mode:'copy'

    input:
    path fasta_file
    path gtf_file 

    output:
    path 'star' 

    script:
    """
    STAR --runThreadN $task.cpus \
    --runMode genomeGenerate \
    --genomeDir ./star \
    --genomeSAindexNbases 12 \
    --genomeFastaFiles ${fasta_file} \
    --sjdbGTFfile ${gtf_file}
    """
}