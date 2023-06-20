process RSEM_INDEX {
    container "danhumassmed/star-rsem:1.0.0"
    publishDir params.outdir, mode:'copy'

    input:
    path fasta_file
    path gtf_file 

    output:
    path '/rsem/WBPS18' 

    script:
    """
    rsem-prepare-reference \
    --gtf ${gtf_file} \
    ${fasta_file} \
    ./rsem/WBPS18
    """
}