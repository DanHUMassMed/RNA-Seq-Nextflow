params.outdir = 'results'

process DEBROWSER {
    //tag "DEBROWSER on $host"
    container 'danhumassmed/debrowser:1.0.1'
    queue = 'interactive'
    time '10m'

    script:
    """
    Rscript /startDEBrowser.R
    """
}
