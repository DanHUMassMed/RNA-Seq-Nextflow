
process WORMCAT {
    container 'danhumassmed/wormcat_batch:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    path excel_file

    output:
    path "wormcat_out" 

    script:
    """
    wormcat_cli -i ${excel_file} -o wormcat_out
    """
}
