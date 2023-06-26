params.outdir = 'results'

process DECOY_TRANSCRIPTOME {
    container 'danhumassmed/samtools-bedtools:1.0.1'
    publishDir params.outdir, mode:'copy'

    input:
    path annotation_file
    path genome_file
    path transcripts_file

    output:
    path "decoy_transcriptome", emit: decoy_transcriptome

    script:
    """
    generateDecoyTranscriptome.sh -j $task.cpus -a ${annotation_file} -g ${genome_file} -t ${transcripts_file} -o decoy_transcriptome
    """
}
