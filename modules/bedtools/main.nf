
process DECOY_TRANSCRIPTOME {
    container 'danhumassmed/samtools-bedtools:1.0.1'
    publishDir params.results_dir, mode:'copy'

    input:
    path annotation_file
    path genome_file
    path transcripts_file

    output:
    path "salmon_transcripts/gentrome.fa", emit: gentrome_fa

    script:
    """
    generateDecoyTranscriptome.sh -j $task.cpus -a ${annotation_file} -g ${genome_file} -t ${transcripts_file} -o salmon_transcripts
    """
}
