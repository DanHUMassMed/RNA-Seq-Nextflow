
//http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf

/**********************************
Phred+33 Scores

Quality | Prob.       | Accuracy
 Score  | Score is    |    of 
        | Incorrect   | Base Call
====================================
   10   | 1 in 10     | 90%
   20   | 1 in 100    | 99%
   30   | 1 in 1,000  | 99.90%
   40   | 1 in 10,000 | 99.99%
*************************************/

process TRIM_SLIDING_WINDOW {
    container "danhumassmed/picard-trimmomatic:1.0.1"

    input:
    tuple val(sample_id), path(reads)
    val data_root
    val dir_suffix

    script:
    def trim_control='"SLIDINGWINDOW:4:15 MINLEN:75"'
    """
    trimmomatic.sh ${reads[0]} ${reads[1]} ${data_root} ${dir_suffix} ${trim_control}
    """

    output:
    path "trim_${dir_suffix}" 

}

process TRIM_HEADCROP {
    container "danhumassmed/picard-trimmomatic:1.0.1"

    input:
    tuple val(sample_id), path(reads)
    val data_root
    val dir_suffix

    script:
    def trim_control='"HEADCROP:8 MINLEN:75"'
    """
    ${launchDir}/bin/trimmomatic.sh ${reads[0]} ${reads[1]} ${data_root} ${dir_suffix} ${trim_control}
    """

    output:
    path "trim_${dir_suffix}" 

}

process TRIM_AGGREGATE {
    container "danhumassmed/picard-trimmomatic:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    path('*')

    script:
    """
    ${launchDir}/bin/trimmomatic_aggregate.sh
    """

    output:
    path "trimmed" 

}

