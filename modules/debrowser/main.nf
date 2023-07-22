params.outdir = 'results'

process DEBROWSER {
    container 'danhumassmed/debrowser:1.0.1'

    input:
    val  email

    script:
    """
    Rscript /startDEBrowser.R
    """
}
