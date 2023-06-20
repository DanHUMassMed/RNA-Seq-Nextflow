params.outdir = 'results'

process MULTIQC {
    container 'danhumassmed/fastqc-multiqc:1.0.0'
    publishDir params.outdir, mode:'copy'

    input:
    path('*')

    output:
    path('multiqc_report.html')

    script:
    """
    multiqc .
    """
}
