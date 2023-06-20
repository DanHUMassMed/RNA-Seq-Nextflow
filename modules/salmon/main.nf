
process INDEX {
    tag "$transcriptome.simpleName"
    container "danhumassmed/salmon-kallisto:1.0.0"
    
    input:
    path transcriptome 

    output:
    path 'index' 

    script:
    """
    salmon index --threads $task.cpus -t $transcriptome -i index
    """
}

process QUANT {
    tag "$pair_id"
    container "danhumassmed/salmon-kallisto:1.0.0"

    input:
    path index 
    tuple val(pair_id), path(reads) 

    output:
    path pair_id 

    script:
    """
    salmon quant --threads $task.cpus --libType=U -i $index -1 ${reads[0]} -2 ${reads[1]} -o $pair_id
    """
}


