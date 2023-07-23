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

process GET_DROPBOX_DATA {
    container 'danhumassmed/de-seq-tools:1.0.1'
    publishDir baseDir, mode:'move'

    input:
    val data_remote 
    val data_local
    
    output:
    path "${data_local}"
    val "${data_local}", emit: data_local_dir

    script:
    """
    mkdir -p "${data_local}"
    get_dropbox_data.sh "${data_remote}" "${data_local}"
    """
}

process CHECK_MD5 {
    container 'danhumassmed/de-seq-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    val data_local
    
    output:
    path "md5_report.html"

    script:
    """
    check_md5.sh "${baseDir}/${data_local}"
    """
}
