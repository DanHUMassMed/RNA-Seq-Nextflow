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
