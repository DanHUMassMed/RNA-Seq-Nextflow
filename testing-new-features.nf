#!/usr/bin/env nextflow 

import java.util.UUID

List<String> generateUUIDs(int numberOfUUIDs) {
    List<String> uuidList = []
    for (int i = 0; i < numberOfUUIDs; i++) {
        UUID uuid = UUID.randomUUID()
        uuidList.add(uuid.toString())
    }
    return uuidList
}


nextflow.enable.dsl = 2

params.reads = "${baseDir}/data/mike_francis/**/*_{1,2}.fq.gz"
params.data_root="mike_francis"
params.outdir = "results"

log.info """\
 TEST - N F   P I P E L I N E
 ===================================
 reads        : ${params.reads}
 outdir       : ${params.outdir}
 base_dir     : ${baseDir}
 """


process TRIM_TEST {
    container "danhumassmed/picard-trimmomatic:1.0.1"
    publishDir params.outdir, mode:'copy'

    input:
    tuple val(sample_id), path(reads)
    val data_root
    val dir_suffix

    script:
    def trim_control="HEADCROP:10 MINLEN:36"
    """
    testing-new-features.sh ${reads[0]} ${reads[1]} ${data_root} ${dir_suffix} ${trim_control}
    """

    output:
    path "test_${dir_suffix}" 

}

/* 
 * main script flow
 */
workflow {
  read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true )
  List<String> uuids = generateUUIDs(50)
  dir_suffix = channel.fromList(uuids)
  TRIM_TEST( read_pairs_ch, params.data_root, dir_suffix )
}

/* 
 * completion handler
 */
workflow.onComplete {
  def msg = """\
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """
        .stripIndent()

    sendMail(to: 'daniel.higgins@umassmed.edu', subject: 'TRIMMOMATIC completed', body: msg)

	log.info ( workflow.success ? "\nDone! The results can be found in --> ${baseDir}/${params.outdir}/trimmed\n" : "Oops .. something went wrong" )
}
