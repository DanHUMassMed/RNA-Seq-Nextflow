
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
    ${launchDir}/bin/tx2gene_map.py --input-file ${transcriptome} --output-file salmon_transcripts/tx2gene.tsv
    """
}

process TXIMPORT_COUNTS {
    container 'danhumassmed/de-seq-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    path('*')
    path tx2gene
    val count_method 

    output:
    path "salmon_summary"

    script:
    """
    mkdir -p salmon_summary
    ${launchDir}/bin/tx_import.R --input-path . --output-path salmon_summary --tx2gene ${tx2gene} --counts-method ${count_method}
    """
}

process LOW_COUNT_FILTER {
    container 'danhumassmed/de-seq-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    path counts_file
    val low_count_max 

    output:
    path "low_count_summary"
    env file_nm, emit: low_count_file
    

    script:
    """
    mkdir -p low_count_summary
    touch low_count_summary/count_data_low_counts_filtered.tsv
    file_nm=\$(readlink -f low_count_summary/count_data_low_counts_filtered.tsv)
    ${launchDir}/bin/low_counts_filter.R --input-counts-file ${counts_file} --output-path low_count_summary --low-count-filter ${low_count_max}
    """
}

process DESEQ_EXEC {
    container 'danhumassmed/de-seq-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    val low_counts_file
    path deseq_meta_file 

    output:
    path "deseq_${deseq_meta_file.getName().split("\\.")[0]}"
    
    

    script:
    """
    mkdir -p deseq_${deseq_meta_file.getName().split("\\.")[0]}
    ${launchDir}/bin/run_deseq2.R --input-counts-file ${low_counts_file} \
                                  --output-path deseq_${deseq_meta_file.getName().split("\\.")[0]} \
                                  --run-meta-filename ${deseq_meta_file}
    """
}

process GET_DROPBOX_DATA {
    container 'danhumassmed/de-seq-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    val data_remote 
    val data_local

    script:
    """
    mkdir -p "${data_local}"
    ${launchDir}/bin/get_dropbox_data.sh "${data_remote}" "${data_local}"
    """

    output:
    path "${data_local}", emit: data_local_dir
    
}

process CHECK_MD5 {
    container 'danhumassmed/de-seq-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    path data_local
    
    script:
    """
    ${launchDir}/bin/check_md5.py "${data_local}"
    """

    output:
    path "md5_report.html"

}
