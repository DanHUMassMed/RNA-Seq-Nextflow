
process FASTQC {
    tag "FASTQC on $sample_id"
    label 'process_medium'
    container 'danhumassmed/qc-tools:1.0.1'
    publishDir "${params.results_dir}/fastqc", mode:'copy'

    input:
    tuple val(sample_id), path(reads)

    output:
    path "${sample_id}_logs" 

    script:
    """
    mkdir ${sample_id}_logs
    fastqc -o ${sample_id}_logs -f fastq -q ${reads}
    """
}

process FASTQC_SINGLE {
    tag "FASTQC on ${reads.getName().split("\\.")[0]}"
    label 'process_medium'
    container 'danhumassmed/qc-tools:1.0.1'
    publishDir "${params.results_dir}/fastqc", mode:'copy'

    input:
    path reads

    output:
    path "${reads.getName().split("\\.")[0]}_logs" 

    script:
    def file_name_prefix = reads.getName().split("\\.")[0]
    """
    mkdir ${file_name_prefix}_logs
    fastqc -o ${file_name_prefix}_logs -f fastq -q ${reads}
    """
}

process DESEQ_REPORT {
    label 'process_low'
    container 'danhumassmed/qc-tools:1.0.1'
    publishDir params.results_dir, mode:'copy'

    input:
    path report_config
    
    script:
    """
    cp -r ${launchDir}/bin/md_to_pdf/* .
    deseq_report.py --report-config "${report_config}"
    """

    output:
    path "deseq_report.pdf"

}


process OVERVIEW_REPORT {
    label 'process_low'
    container 'danhumassmed/qc-tools:1.0.1'
    publishDir params.results_dir, mode:'copy'

    input:
    path report_config
    
    script:
    """
    cp -r ${projectDir}/assests/md_to_pdf/* .
    overview_report.py --report-config "${report_config}"
    """

    output:
    path "overview_report.pdf"

}

