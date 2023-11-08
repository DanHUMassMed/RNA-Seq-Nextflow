

process WORMCAT_CSV {
    container 'danhumassmed/wormcat_batch:1.0.1'
    publishDir params.results_dir, mode:'copy'

    input:
    path csv_path

    output:
    path "wormcat_${csv_path}" 

    script:
    """
    wormcat_cli --input-csv-path ${csv_path} --output-path wormcat_${csv_path}  --clean-temp False
    """
}

process WORMCAT {
    container 'danhumassmed/wormcat_batch:1.0.1'
    publishDir params.results_dir, mode:'copy'

    input:
    path excel_file

    output:
    path "wormcat_${excel_file}" 

    script:
    """
    wormcat_cli -i ${excel_file} -o wormcat_out
    """
}
