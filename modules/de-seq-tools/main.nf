params.outdir = 'results'

process TX2GENE {
    tag "$transcriptome.simpleName"
    container 'danhumassmed/de-seq-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    path transcriptome 

    output:
    path "salmon_transcripts/tx2gene.tsv" , emit: tx2gene_tsv

    script:
    """
    mkdir -p salmon_transcripts
    tx2gene_map.py --input-file ${transcriptome} --output-file salmon_transcripts/tx2gene.tsv
    """
}

process TXIMPORT_COUNTS {
    container 'danhumassmed/de-seq-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    path('*')
    path input_path
    path tx2gene
    val count_method 

    output:
    path "salmon_summary"

    script:
    """
    mkdir -p salmon_summary
    tx_import.R --input-path ${input_path} --output-path salmon_summary --tx2gene ${tx2gene} --counts-method ${count_method}
    """
}