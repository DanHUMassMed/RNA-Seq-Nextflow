
process MULTIQC {
    container 'danhumassmed/qc-tools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    val report_nm
    path('*')

    output:
    path(report_nm)

    script:
    """
    multiqc . --filename ${report_nm}
    """
}
