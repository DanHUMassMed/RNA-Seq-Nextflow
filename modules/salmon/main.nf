
process SALMON_INDEX {
    tag "$transcriptome.simpleName"
    container "danhumassmed/salmon-kallisto:1.0.1"
    publishDir params.results_dir, mode:'copy'
    
    input:
    path transcriptome 

    output:
    path 'salmon_index' 

    script:
    """
    salmon index --threads $task.cpus -t $transcriptome -i salmon_index
    """
}

process SALMON_QUANTIFY_SINGLE  {
    tag "SALMON_QUANTIFY_SINGLE on ${reads.getName().split("\\.")[0]}"
    container "danhumassmed/salmon-kallisto:1.0.1"
    publishDir params.results_dir, mode:'copy'

    input:
    path index 
    path reads 

    output:
    path "salmon_expression_${reads.getName().split("\\.")[0]}"

    script:
    """
    salmon quant --gcBias --threads $task.cpus --libType=U -i $index -r ${reads} -o ./salmon_expression_${reads.getName().split("\\.")[0]}
    """
}

process SALMON_QUANTIFY{
    tag "SALMON_QUANTIFY on $pair_id"
    container "danhumassmed/salmon-kallisto:1.0.1"
    publishDir params.results_dir, mode:'copy'

    input:
    path index 
    tuple val(pair_id), path(reads) 

    output:
    path "salmon_expression_${pair_id}"

    script:
    """
    salmon quant --gcBias --threads $task.cpus --libType=U -i $index -1 ${reads[0]} -2 ${reads[1]} -o ./salmon_expression_${pair_id}
    """
}

process SALMON_SUMMARY {
    // NOTE: expression_summary.py  requires panadas and star-rsem:1.0.1 has it installed
    container "danhumassmed/star-rsem:1.0.1"
    publishDir params.results_dir, mode:'copy'

    input:
    path('*')

    output:
    path "salmon_summary" 

    script:
    """
    mkdir -p salmon_summary
    cd salmon_summary
    expression_summary.py --expression-type salmon --input-path ${baseDir}/${params.results_dir}
    """
}



