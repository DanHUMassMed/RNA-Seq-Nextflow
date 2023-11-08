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



log.info """\
 TRIMMOMATIC - N F   P I P E L I N E
 ===================================
 fastq_paired : ${params.fastq_paired}
 data_for     : ${params.data_for}
 results_dir  : ${params.results_dir}
 """

// import modules
include { TRIM_HEADCROP; TRIM_AGGREGATE } from "${launchDir}/modules/trimmomatic"

/* 
 * main script flow
 */
workflow {
  read_pairs_ch = channel.fromFilePairs( params.fastq_paired, checkIfExists: true )
  dir_suffix = channel.fromList(generateUUIDs(50))

  TRIM_HEADCROP( read_pairs_ch, params.data_for, dir_suffix )
  TRIM_AGGREGATE(TRIM_HEADCROP.out.collect() )
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

	log.info ( workflow.success ? "\nDone! The results can be found in --> ${params.results_dir}/trimmed\n" : "Oops .. something went wrong" )
}
