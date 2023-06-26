
process SALMON_INDEX {
    tag "$transcriptome.simpleName"
    container "danhumassmed/salmon-kallisto:1.0.1"
    publishDir params.outdir, mode:'copy'
    
    input:
    path transcriptome 

    output:
    path 'salmon_index' 

    script:
    """
    salmon index --threads $task.cpus -t $transcriptome/gentrome.fa -i salmon_index
    """
}

process SALMON_QUANTIFY {
    tag "$pair_id"
    container "danhumassmed/salmon-kallisto:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    path index 
    tuple val(pair_id), path(reads) 

    output:
    path "./salmon_expression_${pair_id}"

    script:
    """
    salmon quant --threads $task.cpus --libType=U -i $index -1 ${reads[0]} -2 ${reads[1]} -o ./salmon_expression_${pair_id}
    """
}


